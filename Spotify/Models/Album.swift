//
//  Album.swift
//  Spotify
//
//  Created by Alex Ochigov on 7/24/23.
//

import Foundation

struct Album: Codable {
    let id: String
    let album_type: String
    let available_markets: [String]
    let images: [Image]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}
