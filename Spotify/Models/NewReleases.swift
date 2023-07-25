//
//  NewReleases.swift
//  Spotify
//
//  Created by Alex Ochigov on 6/1/23.
//

import Foundation

struct NewReleases: Codable {
    let albums: Albums
}

struct Albums: Codable {
    let items: [Album]
    let limit: Int
    let offset: Int
    let total: Int
}

struct Image: Codable {
    let url: String
}


