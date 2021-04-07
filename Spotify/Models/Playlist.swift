//
//  Playlist.swift
//  Spotify
//
//  Created by Sam on 4/4/21.
//

import Foundation

struct Playlist: Codable {
    let collaborative: Bool
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: PlaylistOwner
}

struct PlaylistOwner: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
