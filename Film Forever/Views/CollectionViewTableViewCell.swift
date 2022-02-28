//
//  CollectionViewTableViewCell.swift
//  Film Forever
//
//  Created by Duncan K on 20/02/2022.
//

import UIKit


protocol CollectionViewTableViewCellDelegate: AnyObject {
    func CollectionViewTableViewCellDidTapCell(_ cell:  CollectionViewTableViewCell, viewNodel: PreviewViewModel)
}

/// Defines a horizontal collectionview for home view controller table view

class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private var movies: [Movie] = [Movie]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with movies: [Movie] ){
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}


extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        guard let titleName = movie.title ?? movie.original_title else{return}
        getTrailer(movieTitle: titleName, indexPath: indexPath)
    }
    
    private func getTrailer(movieTitle:String, indexPath: IndexPath){
        ApiCaller.shared.getMovieTrailerWithQuery(query: movieTitle + "trailer"){ [weak self] results in
            switch results{
            case .success(let data):
                print(data)
                guard let videoElement = data.items?[0]?.id else {return}
                guard let overview = self?.movies[indexPath.row].overview else {return}
                guard let strongSelf = self else {return}
                let viewModel =  PreviewViewModel(title: movieTitle  , youtubeVideo: videoElement , overview: overview)
                self?.delegate?.CollectionViewTableViewCellDidTapCell(strongSelf, viewNodel: viewModel)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
