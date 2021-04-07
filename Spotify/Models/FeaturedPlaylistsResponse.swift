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
