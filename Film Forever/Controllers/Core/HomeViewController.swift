//
//  HomeViewController.swift
//  Film Forever
//
//  Created by Duncan K on 20/02/2022.
//

import UIKit


enum Sections: Int{
    case Trendingmovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

/**
 Conform to datasource and delegate protocals via extension.
 
 
 Each row will contain CollectionViewTableViewCell
 
 */
class HomeViewController: UIViewController {
    
    let sectiontitles:[String] = ["Trending Movies", "Trending Tv",  "Popular", "Upcomming Movies", "Top rated"]
    
    /**
     Create grouped table view
     
     
     1. Set datasource, delegate and headerview.
     2. HeaderView contains films with the highest priority enabling the user to quickly navigate and watch.
     3. Make tableView to cover the entire screen in viewDidLayoutSubviews()
     */
    let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        let headerView = HeroHeaderUIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 450)
        homeFeedTable.tableHeaderView = headerView

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar(){
        var image = UIImage(named: "AppIcon")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image:  UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image:  UIImage(systemName: "play.circle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .systemRed
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectiontitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell()}
        
        switch indexPath.section{
        case Sections.Trendingmovies.rawValue:
            ApiCaller.shared.getTrendingMovies{ results in
                switch results{
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.TrendingTv.rawValue:
            ApiCaller.shared.getTrendingTvShows{ results in
                switch results{
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Popular.rawValue:
            ApiCaller.shared.getPopularMovies{ results in
                switch results{
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Upcoming.rawValue:
            ApiCaller.shared.getUpcomingShows{ results in
                switch results{
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.TopRated.rawValue:
            ApiCaller.shared.getTopRatedMovies{ results in
                switch results{
                case .success(let data):
                    cell.configure(with: data.results)
                case .failure(let error):
                    print(error)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectiontitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.text = header.textLabel?.text?.capitalized
        header.textLabel?.textColor = .secondaryLabel
        header.textLabel?.frame = CGRect(x: header.bounds.minX + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
}

