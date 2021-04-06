//
//  UserProfile.swift
//  Spotify
//
//  Created by Sam on 4/4/21.
//

import Foundation

struct UserProfile: Codable {
    let id: String
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
//    let followers: [String: Codable?]
    let images: [APIImage]
    let product: String
    let type: String
    let uri: String
}
