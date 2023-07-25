//
//  ProfileHandler.swift
//  Spotify
//
//  Created by Alex Ochigov on 7/25/23.
//

import Foundation

struct ProfileHandler {

    typealias CompletionUserProfile = (Response<UserProfile>) -> Void

    static func fetchProfile(completion: @escaping CompletionUserProfile) {
        let opts = RequestOptions(url: "\(Constants.Base.url)/me", method: .GET)

        APIClient.makeRequest(opts) { (result: Response<UserProfile>) in
            completion(result)
        }
    }
}
