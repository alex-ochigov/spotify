//
//  Profile.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import Foundation

struct UserProfile: Codable {
    let id: String
    let country: String
    let displayName: String
    let email: String
    let href: String
    let product: String
    let images: [UserImage?]
    let followers: UserFollowers
}

struct UserImage: Codable {
    let url: String
}

struct UserFollowers: Codable {
    let href: String
    let total: Int
}
