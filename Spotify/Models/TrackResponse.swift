//
//  TrackResponse.swift
//  Spotify
//
//  Created by Sam on 4/5/21.
//

import Foundation

struct TrackResponse: Codable {
    let id: String
    let name: String
    let artists: [Artist]
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let preview_url: String
}
