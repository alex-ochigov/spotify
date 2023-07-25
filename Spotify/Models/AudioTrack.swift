//
//  AudioTrack.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import Foundation

struct AudioTrack: Codable {
    let id: String
    let name: String
    let album: Album
    let artists: [Artist]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let popularity: Int
}
