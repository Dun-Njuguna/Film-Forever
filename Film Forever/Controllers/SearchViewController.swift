//
//  SearchViewController.swift
//  Film Forever
//
//  Created by Duncan K on 20/02/2022.
//

import UIKit



class SearchViewController: UIViewController  {
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    private var films:[Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8))
        
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .always
        }
        
    }
    
    
    private func fetchUpcoming(){
        ApiCaller.shared.getNowPlaying{ results in
            switch results{
            case .success(let data):
                self.films = data.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    private var collectionViewContentWidth: CGFloat {
        return collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: films[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 13
        let totalSpacing = (2 * Constants.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        
        var itemWidth = width
        
        if(width > CGFloat(Constants.hozontal_movie_view_cell_width)){
            itemWidth = CGFloat(Constants.hozontal_movie_view_cell_width)
        }
        else{
            itemWidth = width
        }
        
        return CGSize(width: itemWidth, height: collectionView.bounds.width/2)
        
    }
    
}

