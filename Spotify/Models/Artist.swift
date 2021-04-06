//
//  Artist.swift
//  Spotify
//
//  Created by Sam on 4/4/21.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
