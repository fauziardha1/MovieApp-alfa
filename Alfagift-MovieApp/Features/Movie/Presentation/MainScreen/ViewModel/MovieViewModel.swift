//
//  MovieViewModel.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 06/01/23.
//

import Foundation


class MovieViewModel {
    
    private var apiService = ApiService()
    private var coreDataManager = CoreDataManger()
    var discoverMovies = [Film]()
    var isConnectionOn = true
    
    
    init() {
        isConnectionOn = Reachability.isConnectedToNetwork()
    }
    
    func setNextpage()  {
        self.apiService.page += 1
    }
    
    func setNextPageReview(){
        self.apiService.reviewPage += 1
    }
    
    func getConnectionStatus() -> Bool {
        Reachability.isConnectedToNetwork()
    }
    
    func fetchDiscoverMoviesData(completion: @escaping () -> ()) {
        self.isConnectionOn = Reachability.isConnectedToNetwork()
        
        if self.isConnectionOn {
            apiService.getDiscoverMoviesData { [weak self] (result) in
                
                switch result {
                case .success(let listOf):
                    self?.discoverMovies = listOf.results
                    self?.coreDataManager.fetchMovies()
                    
                    if (self?.apiService.getDiscoverMoviePage())! * 20 > (self?.coreDataManager.items?.count ?? 0){
                        for movie in self!.discoverMovies {
                            self!.coreDataManager.saveDataToCoreData(movie)
                        }
                    }
                    completion()
                    
                case .failure(_):
                    self?.isConnectionOn = false
                }
            }
            
        } else {
            
            coreDataManager.fetchMovies()
            for data in coreDataManager.items! {
                let film = Film(adult: data.adult, backdropPath: data.backdropPath, genreIDS: data.genreIDS!, id: Int(data.id), originalLanguage: data.originalLanguage, originalTitle: data.originalTitle, overview: data.overview, popularity: data.popularity, posterPath: data.posterPath, releaseDate: data.releaseDate, title: data.title, video: data.video, voteAverage: data.voteAverage, voteCount: Int(exactly: data.voteCount)!)
                self.discoverMovies.append(film)
            }
            completion()
            
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if discoverMovies.count != 0 {
            return discoverMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Film {
        return discoverMovies[indexPath.row]
    }
    
    // get number of data in coredata
    func coredataMovieCount() -> Int{
        return self.coreDataManager.items?.count ?? 0
    }

}
