//
//  ApiService.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 06/01/23.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    var page = 1
    var reviewPage = 1
        
     func getDiscoverMoviesData(completion: @escaping (Result<DiscoverMovie,Error>) -> Void) {
            let disCoverMoviesURL = "https://api.themoviedb.org/3/discover/movie?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_watch_monetization_types=flatrate"
            
            guard let url = URL(string: disCoverMoviesURL) else {return}
            dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard response is HTTPURLResponse else {return}
                guard let data = data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(DiscoverMovie.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let error {
                    completion(.failure(error))
                }
                
            }
            dataTask?.resume()
        }
    
    // get detail of a movie
    func getMoviesDetail(id : Int, completion: @escaping (Result<MovieDetail,Error>) -> Void) {
        let movieDetailURL = "https://api.themoviedb.org/3/movie/" + "\(id)?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US"
        
        guard let url = URL(string: movieDetailURL) else {return}
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response is HTTPURLResponse else {return}
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieDetail.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
        
        
    }
    
    
    // get movie's review
    func getMovieReview(id : Int, completion: @escaping (Result<Review,Error>) -> Void) {
        let movieReviewURL = "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=\(reviewPage)"
        
        guard let url = URL(string: movieReviewURL) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response is HTTPURLResponse else {return}
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Review.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
        
        
    }
    
    // get video url from api
    func getVideoTrailerURL(id : Int, completion: @escaping (Result<MovieTrailer,Error>) -> Void) {
        let urlVideo = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US"
        guard let url = URL(string: urlVideo) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response is HTTPURLResponse else { return}
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieTrailer.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    
    func getDiscoverMoviePage() -> Int{
        return self.page
    }
}
