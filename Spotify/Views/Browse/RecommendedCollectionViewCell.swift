//
//  RecommendedCollectionViewCell.swift
//  Spotify
//
//  Created by Sam on 4/6/21.
//

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedCollectionViewCell"
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    private let albumCoverImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(trackNameLabel)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            albumCoverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            albumCoverImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            albumCoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            albumCoverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            trackNameLabel.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant: 10),
            trackNameLabel.topAnchor.constraint(equalTo: albumCoverImageView.topAnchor, constant: 10),
            trackNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -albumCoverImageView.width - 30),
            
            
            artistNameLabel.leftAnchor.constraint(equalTo: trackNameLabel.leftAnchor),
            artistNameLabel.bottomAnchor.constraint(equalTo: albumCoverImageView.bottomAnchor, constant: -10),
            
        ])
    }
    
    override func prepareForReuse() {
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil    }
    
    
    func configureModel(viewModel: RecommendCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
