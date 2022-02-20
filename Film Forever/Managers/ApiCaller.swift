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


enum APIError: Error{
    case failedTogetData
}

class ApiCaller {
    static let shared = ApiCaller()
    
    
    func getNowPlaying(completion: @escaping (Result<InTheatresResponse, Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/now_playing?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(InTheatresResponse.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
    func getTrendingMovies(completion: @escaping (Result<TrendingMoviesResponse, Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
    func getTrendingTvShows(completion: @escaping (Result<TrendingTvShowsResponse, Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingTvShowsResponse.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
    func getUpcomingShows(completion: @escaping (Result<UpcomingShowsResponse, Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UpcomingShowsResponse.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<PopularMoviesResponse, Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(PopularMoviesResponse.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
    func getPopularTvShows(completion: @escaping (Result<PopularTvShowsResponse, Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/tv/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(PopularTvShowsResponse.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
    func getTopRatedTvShows(completion: @escaping (Result<TopRatedTvShowsResponse, Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/tv/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}

        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TopRatedTvShowsResponse.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<TopRatedMoviesResponse, Error>) -> Void){
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TopRatedMoviesResponse.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        task.resume()
    }
    
}

