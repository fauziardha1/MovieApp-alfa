//
//  MovieViewModel.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 06/01/23.
//

import Foundation


class MovieViewModel {
    
    private var apiService = ApiService()
     var discoverMovies = [Film]()
    
    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getPopularMoviesData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.discoverMovies = listOf.results
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
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
}
