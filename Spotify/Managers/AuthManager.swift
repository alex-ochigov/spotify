//
//  AuthManager.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    let clientId = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as! String
    let clientSecret = Bundle.main.object(forInfoDictionaryKey: "CLIENT_SECRET") as! String
    
    private init() {}
    
    var isSigned: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshTokn: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
