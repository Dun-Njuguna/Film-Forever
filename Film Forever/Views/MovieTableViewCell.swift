//
//  MovieTableViewCell.swift
//  Film Forever
//
//  Created by Duncan K on 22/02/2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

   static let identifier = "MovieTableViewCell"
    
    private let movieImageView:UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLable:UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.lineBreakMode = .byWordWrapping
        lable.numberOfLines = 0
        return lable
    }()
    
    private let playButton:UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(playButton)
        
        applyConstraignts()
    }
    
    private func applyConstraignts(){
        let movieImageViewConstraignts = [
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            movieImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLableConstraignts = [
            titleLable.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
    
        let playButtonConstrignts = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(movieImageViewConstraignts)
        NSLayoutConstraint.activate(titleLableConstraignts)
        NSLayoutConstraint.activate(playButtonConstrignts)
    }
    
    public func configure(with model: Movie){
        guard let posterUrl: String = model.poster_path else {return}
        guard let url = URL(string: "\(Constants.BASE_IMAGE_URL)\(posterUrl)") else {return}
        movieImageView.sd_setImage(with: url, completed: nil)
        titleLable.text = model.original_title ?? model.title ?? "Unknown"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
}
