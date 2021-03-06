//
//  HeroHeaderUIView.swift
//  Film Forever
//
//  Created by Duncan K on 20/02/2022.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    var gradientLayer : CAGradientLayer?

    private let downloadButton:UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let playButton:UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named:"heroImgae")
        return imageView
    }()
    
    private func addGradient(){
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.addSublayer(gradientLayer!)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraignts()
    }
    
    private func applyConstraignts(){
    
        let playButtonconstraights = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        let downloadButtonconstraights = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
   
        NSLayoutConstraint.activate(playButtonconstraights)
        NSLayoutConstraint.activate(downloadButtonconstraights)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
        gradientLayer?.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
