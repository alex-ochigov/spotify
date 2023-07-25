//
//  Request.swift
//  Spotify
//
//  Created by Alex Ochigov on 7/24/23.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

struct RequestOptions {
    var url: String
    var method: HTTPMethod
}
