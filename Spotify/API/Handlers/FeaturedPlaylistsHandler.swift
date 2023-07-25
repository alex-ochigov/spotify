//
//  FeaturedPlaylistsHandler.swift
//  Spotify
//
//  Created by Alex Ochigov on 7/25/23.
//

import Foundation

struct FeaturedPlaylistsHandler {

    typealias CompletionFeaturedPlaylists = (Response<FeaturedPlaylists>) -> Void

    static func fetchFeaturedPlaylists(completion: @escaping CompletionFeaturedPlaylists) {
        let opts = RequestOptions(url: "\(Constants.Base.url)/featured-playlists?limit=50", method: .GET)

        APIClient.makeRequest(opts) { (result: Response<FeaturedPlaylists>) in
            completion(result)
        }
    }
}
