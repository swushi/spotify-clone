//
//  APICaller.swift
//  Spotify
//
//  Created by Sam on 4/4/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}

    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }

    enum APIError: Error {
        case failedToGetData
        case failedToParseJSON
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let url = URL(string: Constants.baseAPIURL + "/me")
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(UserProfile.self, from: data)
                    print("got user profile")
                    completion(.success(results))
                } catch {
                    completion(.failure(APIError.failedToGetData))
                }
            }
            task.resume()
        }
    }
    
    public func getNewReleases(completion: @escaping (Result<NewRealeasesResponse, Error>) -> Void) {
        let url = URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50")
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(NewRealeasesResponse.self, from: data)
                    print("got new releases")
                    completion(.success(results))
                    
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(APIError.failedToParseJSON))
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylistsResponse, Error>) -> Void) {
        let url = URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20")
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    print("got feat playlists")
                    completion(.success(results))
                }
                catch {
                    completion(.failure(APIError.failedToParseJSON))
                }
                
                
            }
            task.resume()
        }
    }
    
    public func getRecommendedGenres(completion: @escaping (Result<RecommendedGenresResponse, Error>) -> Void) {
        let url = URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds")
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    print("got recommended genres")
                    completion(.success(results))
                }
                catch {
                    completion(.failure(APIError.failedToParseJSON))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(genres: [String], completion: @escaping (Result<RecommendationsResponse, Error>) -> Void) {
        let csvGenres = genres.joined(separator: ",")
        let url = URL(string: Constants.baseAPIURL + "/recommendations/?seed_genres=\(csvGenres)")
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let rawJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(rawJSON)
                    let results = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    print("got recommendations")
                    completion(.success(results))
                }
                catch {
                    completion(.failure(APIError.failedToParseJSON))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        guard let apiURL = url else {
            return
        }
        AuthManager.shared.withValidToken { token in
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            
            completion(request)
        }
    }
    
    
}
