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
        // get connection status
        isConnectionOn = Reachability.isConnectedToNetwork()
    }
    
    func fetchDiscoverMoviesData(completion: @escaping () -> ()) {
        
        if self.isConnectionOn {
            print("trying get data form api")
            // weak self - prevent retain cycles
            apiService.getPopularMoviesData { [weak self] (result) in
                
                switch result {
                case .success(let listOf):
                    self?.discoverMovies = listOf.results
                    // save to coredata
                    for movie in self!.discoverMovies {
                        self!.coreDataManager.saveDataToCoreData(movie)
                    }
                    
                    // set it donw using completion
                    completion()
                    
                case .failure(let error):
                    // Something is wrong with the JSON file or the model
                    print("Error processing json data: \(error)")
                    self?.isConnectionOn = false
                }
            }
            
        } else {
            
            print("trying to get data form coredata")
            // get from coredata
            coreDataManager.fetchMovies()
            for data in coreDataManager.items! {
                let film = Film(adult: data.adult, backdropPath: data.backdropPath, genreIDS: data.genreIDS!, id: Int(data.id), originalLanguage: data.originalLanguage, originalTitle: data.originalTitle, overview: data.overview, popularity: data.popularity, posterPath: data.posterPath, releaseDate: data.releaseDate, title: data.title, video: data.video, voteAverage: data.voteAverage, voteCount: Int(exactly: data.voteCount)!)
                self.discoverMovies.append(film)
            }
            // set it donw using completion
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
