//
//  DetailViewModel.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 09/02/23.
//

import Foundation


class DetailViewModel{
    var isConnectionOn = true
    private var apiService = ApiService()
    private var movieDetail = [MovieDetail]()
    private var reviews = [Item]()
    private var trailerURL = ""
    
    func getConnectionStatus() -> Bool {
        Reachability.isConnectedToNetwork()
    }
    
    // get movie's detail from api
    func getMoviesDetailFromAPI(id : Int, completion : @escaping () ->())  {
        self.isConnectionOn = Reachability.isConnectedToNetwork()
        
        if self.isConnectionOn {
            apiService.getMoviesDetail(id: id) { [weak self] (result) in
                
                switch result {
                case .success(let detail):
                    self?.movieDetail = [detail]
                    completion()
                    
                case .failure(_):
                    self?.isConnectionOn = false
                }
            }
            
        }
        else {
            
        }
            
    }
    
    func getMovieDetailInstance() -> [MovieDetail] {
        return self.movieDetail
    }
    
    // get movie reviews from api
    func getMovieReviewsFromAPI(id : Int, completion : @escaping () ->())  {
        self.isConnectionOn = Reachability.isConnectedToNetwork()
        
        if self.isConnectionOn {
            apiService.getMovieReview(id: id) { [weak self] (result) in
                
                switch result {
                case .success(let data):
                    self?.reviews = data.results!
                    completion()
                    
                case .failure(_):
                    self?.isConnectionOn = false
                }
            }
            
        }
        else {
            
        }
            
    }
    
    func getReviews() -> [Item] {
        return self.reviews
    }
    
    // TODO: get video url from api
    func getMovieTrailerFromAPI(id : Int, completion : @escaping () ->())  {
        self.isConnectionOn = Reachability.isConnectedToNetwork()
        
        if self.isConnectionOn {
            apiService.getVideoTrailerURL(id: id) { [weak self] (result) in
                
                switch result {
                case .success(let data):
                    for trailer in data.videos! {
                        if trailer.type == "Trailer"{
                            self?.trailerURL = trailer.key!
                            break
                        }
                    }
                    completion()
                    
                case .failure(_):
                    self?.isConnectionOn = false
                }
            }
            
        }
        else {
        }
            
    }
    
    func getTrailerURL() -> String{
        return self.trailerURL
    }
    
    func setNextPageReview()  {
        self.apiService.reviewPage += 1
    }

}
