//
//  ViewController.swift
//  Spotify
//
//  Created by Sam on 4/4/21.
//

import UIKit

enum BrowseSectionType {
    case newReleases(viewModel: [NewReleasesCellViewModel])
    case featuredPlaylists(viewModel: [FeaturedPlaylistCellViewModel])
    case recommendedTracks(viewModel: [RecommendCellViewModel])
}

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionLayout(section: sectionIndex)
    })
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
        
    }()
    
    private var sections = [BrowseSectionType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapSettings))
        
        configureCollectionView()
        view.addSubview(spinner)
        
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturedPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
        collectionView.register(RecommendedCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var newReleases: NewRealeasesResponse?
        var featuredPlaylists: FeaturedPlaylistsResponse?
        var recommendedTracks: RecommendationsResponse?
        
        // New Releases
        APICaller.shared.getNewReleases { result in
            defer {
                group.leave()
            }
            switch(result) {
            case .success(let model):
                newReleases = model
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        // Featured Playlists
        APICaller.shared.getFeaturedPlaylists { result in
            defer {
                group.leave()
            }
            switch(result) {
            case .success(let model):
                featuredPlaylists = model
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        // Recommended Tracks
        APICaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let genresResponse):
                let genres = genresResponse.genres
                var genresForRecommendation = [String]()
                
                for _ in 0..<5 {
                    if let genre = genres.randomElement() {
                        genresForRecommendation.append(genre)
                    }
                }
                
                APICaller.shared.getRecommendations(genres: genresForRecommendation) { recommendedResult in
                    defer {
                        group.leave()
                    }
                    switch(recommendedResult) {
                    case .success(let model):
                        recommendedTracks = model
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                }
                
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }

        }
        
        group.notify(queue: .main) { [weak self] in
            guard let releases = newReleases?.albums.items,
                  let playlists = featuredPlaylists?.playlists.items,
                  let recommendations = recommendedTracks?.tracks else {
                fatalError("Models are nil")
            }
            print("releases", releases.count)
            print("playlists", playlists.count)
            print("recommendations", recommendations.count)
            self?.configureModels(
                releases: releases,
                playlists: playlists,
                recommendations: recommendations
            )
        }
    }
    
    private func configureModels(
        releases: [Album],
        playlists: [Playlist],
        recommendations: [Track]
    ) {
        sections.append(.newReleases(viewModel: releases.compactMap({
            return NewReleasesCellViewModel(
                name: $0.name,
                artworkURL: URL(string: $0.images.first?.url ?? ""),
                numberOfTracks: $0.total_tracks,
                artistName: $0.artists.first?.name ?? "-"
            )
        })))
        
        sections.append(.featuredPlaylists(viewModel: playlists.compactMap({ playlist in
            return FeaturedPlaylistCellViewModel(
                name: playlist.name,
                artworkUrl: URL(string: playlist.images.first?.url ?? ""),
                creatorName: playlist.owner.display_name
            )
        })))
        
        sections.append(.recommendedTracks(viewModel: recommendations.compactMap({ recommendation in
            return RecommendCellViewModel(
                name: recommendation.name,
                artistName: recommendation.artists.first?.name ?? "-",
                duration: recommendation.duration_ms / 1000,
                explicit: recommendation.explicit ?? false,
                artworkURL: URL(string: recommendation.album.images.first?.url ?? "")
            )
        })))
        collectionView.reloadData()
    }
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .featuredPlaylists(let model):
            return model.count
        case .newReleases(let model):
            return model.count
        case .recommendedTracks(let model):
            return model.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .featuredPlaylists(let models):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier,
                for: indexPath
            ) as? FeaturedPlaylistCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = models[indexPath.row]
            cell.configureModel(viewModel: model)
            return cell
        case .newReleases(let models):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewReleaseCollectionViewCell.identifier,
                for: indexPath
            ) as? NewReleaseCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = models[indexPath.row]
            cell.configure(with: model)
            return cell
        case .recommendedTracks(let models):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecommendedCollectionViewCell.identifier,
                for: indexPath
            ) as? RecommendedCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = models[indexPath.row]
            cell.configureModel(viewModel: model)
            return cell
        }
        
    }
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            // item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(260)),
                subitem: item,
                count: 3
            )
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(260)),
                subitem: verticalGroup,
                count: 1
            )
            
            // section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        case 1:
            // item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                ))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                ),
                subitem: item,
                count: 2
            )
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(185),
                    heightDimension: .absolute(500)
                ),
                subitem: verticalGroup,
                count: 1
            )

            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
        case 2:
            // item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(80)),
                subitem: item,
                count: 1
            )

            
            // section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            return section
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(390)),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}



