//
//  NewReleasesHandler.swift
//  Spotify
//
//  Created by Alex Ochigov on 7/25/23.
//

import Foundation

struct NewReleasesHandler {

    typealias CompletionNewReleases = (Response<NewReleases>) -> Void

    static func fetchNewReleases(completion: @escaping CompletionNewReleases) {
        let opts = RequestOptions(url: "\(Constants.Base.url)/browse/new-releases?limit=50", method: .GET)

        APIClient.makeRequest(opts) { (result: Response<NewReleases>) in
            completion(result)
        }
    }
}
