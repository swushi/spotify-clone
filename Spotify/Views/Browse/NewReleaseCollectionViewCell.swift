//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Sam on 4/6/21.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private let artistNamelabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(artistNamelabel)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumNameLabel.sizeToFit()
        artistNamelabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        
        let imageSize: CGFloat = contentView.height - 10
        albumCoverImageView.frame = CGRect(x: 10, y: 10, width: imageSize, height: imageSize)
        
        numberOfTracksLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNamelabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfTracksLabel.bottomAnchor.constraint(equalTo: albumCoverImageView.bottomAnchor),
            numberOfTracksLabel.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant: 10),
            
            albumNameLabel.topAnchor.constraint(equalTo: albumCoverImageView.topAnchor),
            albumNameLabel.leftAnchor.constraint(equalTo: numberOfTracksLabel.leftAnchor),
            albumNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -albumCoverImageView.width - 20),

            artistNamelabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor),
            artistNamelabel.leftAnchor.constraint(equalTo: albumNameLabel.leftAnchor),
            artistNamelabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -albumCoverImageView.width - 20),
        ])
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNamelabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNamelabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
