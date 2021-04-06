//
//  SettingsModels.swift
//  Spotify
//
//  Created by Sam on 4/5/21.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let text: String
    let handler: () -> Void
}
