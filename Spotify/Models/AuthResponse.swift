//
//  AuthResponse.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/12/23.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let refresh_token: String?
    let expires_in: Int
    let scope: String
    let token_type: String
}
