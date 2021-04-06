//
//  ViewController.swift
//  Spotify
//
//  Created by Sam on 4/4/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapSettings))
        
       fetchData()
    }
    
    func fetchData() {
        APICaller.shared.getNewReleases { result in
//            print(result)
        }
        
        APICaller.shared.getFeaturedPlaylists { result in
//            print(result)
        }
        
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
                
                APICaller.shared.getRecommendations(genres: genresForRecommendation) { recommend in
                    print(recommend)
                }
                
                break
            case .failure(let error): break
            }

        }
    }
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
    }

}

