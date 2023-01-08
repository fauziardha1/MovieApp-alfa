//
//  MainViewController.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 05/01/23.
//

import Foundation
import UIKit


class MainViewController : UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var discoverMovies : DiscoverMovie = DiscoverMovie(page: 0, results: [], totalPages: 0, totalResults: 0)
    var vm = MovieViewModel()
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // get reference to object manage context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // data for table
    var items : [Movie]?
    
    // fetch data from core data and display it
    func fetchDataFromCoreData(){
        do {
            self.items = try context.fetch(Movie.fetchRequest())
            
            print(items ?? [] ,"items")
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        catch {
            print("error occure on fetch data from coredata")
        }
    }
    
    // insert into coredata
    func saveDataToCoreData(_ film : Film){
        // create nsobject of Movie
        let movie = Movie(context: self.context)
        
        // edit attribute
        movie.title = film.title
        movie.posterPath = film.posterPath
        movie.adult = film.adult!
        movie.backdropPath = film.backdropPath
        movie.genreIDS = film.genreIDS! as NSObject
        movie.id = Int32(film.id!)
        movie.originalLanguage = film.originalLanguage
        movie.originalTitle = film.originalTitle
        movie.overview = film.overview
        movie.popularity = film.popularity!
        movie.releaseDate = film.releaseDate
        movie.video = film.video!
        movie.voteAverage = film.voteAverage!
        movie.voteCount = Int16(film.voteCount!)
        
        // save it
        
        do {
            try context.save()
        }
        catch {
            print("error while saving data to coredata")
        }
        
        // show it
        fetchDataFromCoreData()
    }
    
    // delete a data from coredata
    func deleteDataFromCoreData(_ film : Film){
        
        // get the object data
        let objToRemove = self.items?.first(where: { Movie in
            return Movie.id == film.id!
        })
        
        // remove that obj in context
        self.context.delete(objToRemove!)
        
        // save it
        do {
            try context.save()
        }
        catch {
            print("error while saving data to coredata")
        }
        
        // fetch again
        fetchDataFromCoreData()
        
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Movie List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.register(MovieCardCollectionViewCell.self, forCellWithReuseIdentifier: MovieCardCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        
        if Reachability.isConnectedToNetwork(){
            // connected to internet, then fetch from api
            print("connected to network")
            
            vm.fetchDiscoverMoviesData { [self] in
                self.collectionView.reloadData()
                self.discoverMovies.results = self.vm.discoverMovies
                
                saveDataToCoreData(discoverMovies.results[0])
                
                deleteDataFromCoreData(discoverMovies.results[0])
            }
            
            //TODO: save all data that get from api to coredata
            
            
        }else{
            // no internet connection, then fetch from coredata
            print("no internet connection")
            
            
        }
        
        
        
        // fetch data from coredata
        fetchDataFromCoreData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoverMovies.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCardCollectionViewCell.identifier, for: indexPath) as! MovieCardCollectionViewCell
        
        cell.movieName.text = discoverMovies.results[indexPath.row].title
        cell.imageView.load(url: URL(string: imageBaseUrl + discoverMovies.results[indexPath.row].posterPath!)!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/2 ) - 16,
            height: (view.frame.size.width/1.5 ) - 16
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == discoverMovies.results.count - 1  {
            vm.fetchDiscoverMoviesData {
                self.discoverMovies.results.append(contentsOf: self.vm.discoverMovies)
                collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MovieInfoScreenViewController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 12, bottom: -8, right: 12)
    }
    
}



#if DEBUG
import SwiftUI
struct MainViewController_Preview : PreviewProvider {
    static var previews: some View{
        ViewControllerPreview {
            MainViewController()
        }
        .padding(0.0)
    }
}

struct ViewControllerPreview: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> UIViewController
    
    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not needed
    }
}

#endif
