//
//  Playlists.swift
//  Spotify
//
//  Created by Alex Ochigov on 6/1/23.
//

import Foundation

struct FeaturedPlaylists: Codable {
    let message: String
    let playlists: [Playlists]
}
