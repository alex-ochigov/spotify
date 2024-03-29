//
//  Artist.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
