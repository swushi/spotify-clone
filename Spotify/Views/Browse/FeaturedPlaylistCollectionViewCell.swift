//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Sam on 4/6/21.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    private let playlistImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(playlistImageView)
        contentView.addSubview(creatorNameLabel)
        contentView.addSubview(playlistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistImageView.translatesAutoresizingMaskIntoConstraints = false
        playlistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playlistImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.700),
            playlistImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            playlistImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            playlistNameLabel.leftAnchor.constraint(equalTo: playlistImageView.leftAnchor),
            playlistNameLabel.topAnchor.constraint(equalTo: playlistImageView.bottomAnchor),
            playlistNameLabel.widthAnchor.constraint(equalTo: playlistImageView.widthAnchor),
            
            creatorNameLabel.leftAnchor.constraint(equalTo: playlistImageView.leftAnchor),
            creatorNameLabel.topAnchor.constraint(equalTo: playlistNameLabel.bottomAnchor),
            
        ])
    }
    
    override func prepareForReuse() {
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistImageView.image = nil    }
    
    
    func configureModel(viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistImageView.sd_setImage(with: viewModel.artworkUrl)
    }
}
