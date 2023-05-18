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
        let request = createRequest(with: base.appendingPathComponent("/me"), type: .GET)
        makeRequest(request) { (result: Result<UserProfile, Error>) in
            completion(result)
        }
    }
    
    private func makeRequest<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void ) {
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIErrors.failed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func createRequest(with url: URL, type: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        AuthManager.shared.withValidToken { token in
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }

}
