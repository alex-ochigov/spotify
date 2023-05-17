//
//  AuthManager.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private var isTokenRefreshing = false
    
    let clientId = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as! String
    let clientSecret = Bundle.main.object(forInfoDictionaryKey: "CLIENT_SECRET") as! String
    let tokenAPIUrl = "https://accounts.spotify.com/api/token"
    let redirectURL = "spotify://callback"
    let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    
    public var authURL: URL? {
        
        
        let baseURL = "https://accounts.spotify.com/authorize"
        let url = String(
            format: "%@?response_type=code&client_id=%@&scope=%@&redirect_uri=%@&show_dialog=true",
            baseURL,
            clientId,
            scopes,
            redirectURL
        )
        
        return URL(string: url)
    }
    
    private init() {}
    
    var isSigned: Bool {
        return accessToken != nil
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: tokenAPIUrl) else {
            completion(false)
            return
        }
        
        guard let basicToken = "\(clientId):\(clientSecret)".data(using: .utf8)?.base64EncodedString() else {
            completion(false)
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: redirectURL),
        ]
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(basicToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                
                self?.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        
        task.resume()
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !isTokenRefreshing else {
            onRefreshBlocks.append(completion)
            return
        }
        
        refreshTokenIfNeeded { [weak self] success in
            if let token = self?.accessToken, success {
                completion(token)
            }
        }
    }
    
    public func refreshTokenIfNeeded(completion: @escaping (Bool) -> Void) {
        guard !isTokenRefreshing else {
            return
        }
        
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard let basicToken = "\(clientId):\(clientSecret)".data(using: .utf8)?.base64EncodedString() else {
            completion(false)
            return
        }
        
        guard let url = URL(string: tokenAPIUrl) else {
            completion(false)
            return
        }
        
        isTokenRefreshing = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshTokn),
        ]
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(basicToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            self?.isTokenRefreshing = false
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                
                self?.onRefreshBlocks.forEach { $0(result.access_token) }
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        
        task.resume()
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshTokn: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expiration_date") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(
            Date().addingTimeInterval(TimeInterval(result.expires_in)),
            forKey: "expiration_date"
        )
    }
}
