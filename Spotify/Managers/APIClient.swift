//
//  APIClient.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

enum APIErrors: Error {
    case failed
}

final class APIClient {
    static let shared = APIClient()
    private let base = URL(string: "https://api.spotify.com/v1")!
    
    private init() {}
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        run(with: base.appending(path: "/me"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIErrors.failed))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    private func run(
        with url: URL,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void) {
            AuthManager.shared.withValidToken { token in
                var request = URLRequest(url: url)
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.httpMethod = type.rawValue
                completion(request)
            }
        }
}
