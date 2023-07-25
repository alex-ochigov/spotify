//
//  RecommendationHandler.swift
//  Spotify
//
//  Created by Alex Ochigov on 7/25/23.
//

import Foundation

struct RecommendationsHandler {

    typealias CompletionAvailableGenres = (Response<Genres>) -> Void
    typealias CompletionRecommendations = (Response<Recommendations>) -> Void

    static func fetchAvailableGenres(completion: @escaping CompletionAvailableGenres) {
        let opts = RequestOptions(
            url: "\(Constants.Base.url)/recommendations/available-genre-seeds",
            method: .GET
        )

        APIClient.makeRequest(opts) { (result: Response<Genres>) in
            completion(result)
        }
    }

    static func fetchRecommendations(genres: String, completion: @escaping CompletionRecommendations) {
        let opts = RequestOptions(
            url: "\(Constants.Base.url)/recommendations?limit=40&seed_genres=\(genres)",
            method: .GET
        )

        APIClient.makeRequest(opts) { (result: Response<Recommendations>) in
            completion(result)
        }
    }

}
