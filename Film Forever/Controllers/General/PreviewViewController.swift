//
//  PreviewViewController.swift
//  Film Forever
//
//  Created by Duncan K on 28/02/2022.
//

import UIKit
import WebKit

class PreviewViewController: UIViewController {
    
    private let webView:WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        return webview
    }()
    
    private let titileLabel:UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 22, weight: .bold)
        lable.text = "Harry Potter"
        return lable
    }()
    
    
    private let overviewLabel:UILabel = {
        
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 18, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.text = "Best movie to watch"
        return lable
    }()
    
    
    private let downloadButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titileLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        configureConstraints()
    }
    

    
    private func configureConstraints(){
        
        let webviewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250)
        ]
        
        let titleLabelConstarints = [
            titileLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titileLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo:  overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(titleLabelConstarints)
        NSLayoutConstraint.activate(webviewConstraints)
        
    }
    
    
    func configre(with model: PreviewViewModel){
        titileLabel.text = model.title
        overviewLabel.text = model.overview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.videoId)") else {return}
        webView.load(URLRequest(url: url))
    }
    
}
