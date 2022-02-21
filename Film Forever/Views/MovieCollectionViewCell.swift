//
//  TitleCollectionViewCell.swift
//  Film Forever
//
//  Created by Duncan K on 21/02/2022.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageview:UIImageView  = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageview)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageview.frame = contentView.bounds
    }
    
    public func configure(with model:Movie){
        guard let posterUrl: String = model.poster_path else {return}
        guard let url = URL(string: "\(Constants.BASE_IMAGE_URL)\(posterUrl)") else {return}
        posterImageview.sd_setImage(with: url, completed: nil)
    }
    
}
