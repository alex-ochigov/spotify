//
//  Response.swift
//  Spotify
//
//  Created by Alex Ochigov on 7/24/23.
//

import Foundation

typealias Response<T> = Result<T, APIError>

enum APIError: Error {
    case failed
    case invalid
    case badRequest(String)
}
