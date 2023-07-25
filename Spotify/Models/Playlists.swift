//
//  Playlists.swift
//  Spotify
//
//  Created by Alex Ochigov on 6/1/23.
//

import Foundation

struct Playlists: Codable {
    let items: [Playlist]
    let limit: Int
}

struct Playlist: Codable {
    let id: String
    let name: String
    let images: [PlaylistImage]
    let tracks: Tracks
}

struct PlaylistImage: Codable {
    let url: String
}

struct Tracks: Codable {
    let href: String
    let total: Int
}

struct Owner: Codable {
    let id: String
    let type: String
    let display_name: String
}
