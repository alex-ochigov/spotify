//
//  APIClient.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import Foundation

class APIClient {
    
   static func makeRequest<T: Codable>(_ opts: RequestOptions, completion: @escaping (Response<T>) -> Void) {
        guard let requestUrl = URL(string: opts.url) else {
            completion(.failure(APIError.badRequest(opts.url)))
            return
        }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = opts.method.rawValue

        AuthManager.shared.withValidToken { token in
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.invalid))
            }
        }
        
        task.resume()
    }
}
