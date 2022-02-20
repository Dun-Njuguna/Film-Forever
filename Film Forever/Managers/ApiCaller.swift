//
//  ApiCaller.swift
//  Film Forever
//
//  Created by Duncan K on 20/02/2022.
//

import Foundation

struct Constants {
    static let API_KEY = "d59c083ee4818d897be1fad929a8731b"
    static let BASE_URL = "https://api.themoviedb.org"
}


enum APIError{
    case faileTogetData
}

class ApiCaller {
    static let shared = ApiCaller()
    
    
    func getTrendingmovies(completion: @escaping (Result<TrendingMoviesResponse, Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(error))
            }
            
        })
        task.resume()
    }
    
}

