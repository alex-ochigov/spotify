//
//  SettingsItem.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/17/23.
//

import Foundation

struct SectionsItem {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}

