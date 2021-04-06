//
//  FeaturedPlaylistsResopnse.swift
//  Spotify
//
//  Created by Sam on 4/5/21.
//

import Foundation


struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistsResponse
}

struct PlaylistsResponse: Codable {
    let items: [Playlist]
}

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
