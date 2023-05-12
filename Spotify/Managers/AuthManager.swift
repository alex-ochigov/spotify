//
//  AuthManager.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    let clientId = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as! String
    let clientSecret = Bundle.main.object(forInfoDictionaryKey: "CLIENT_SECRET") as! String
    
    public var authURL: URL? {
        let scopes = "user-read-private"
        let redirectURL = "spotify://callback"
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
        return false
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        // get token
    }
    
    public func refreshToken() {
        
    }
    
    public func cacheToken() {
        
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshTokn: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
