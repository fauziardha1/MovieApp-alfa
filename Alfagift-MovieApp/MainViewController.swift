//
//  MainViewController.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 05/01/23.
//

import Foundation
import UIKit


class MainViewController : UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var movies : [Movie] = []
    
    var discoverMovies : DiscoverMovie = DiscoverMovie(page: 0, results: [], totalPages: 0, totalResults: 0)
    let serialQueue = DispatchQueue(label: "getdata")
    
    var vm = MovieViewModel()
    
    
    // get data from api
    let apiKey = "c410263697615899edf2bdf7903a1a05"
    let movieDBUrl = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=c410263697615899edf2bdf7903a1a05")!
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    let session = URLSession.shared
    
    func getMoviesFromAPI(){
        let request = URLRequest(url: movieDBUrl)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(DiscoverMovie.self, from: data)
                    
                    // use the movie data here
                    if self.discoverMovies.results.count == 0 {
                        self.discoverMovies = res
                    }
                    else {
                        self.discoverMovies.results.append(contentsOf: res.results)
                        self.discoverMovies.page += res.page
                        self.discoverMovies.totalPages += res.totalPages
                        self.discoverMovies.totalResults += res.totalResults
                    }
                    
                    print(self.discoverMovies.results.count)
                    
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    func appendData() {
//        for _ in 1...10 {
//            movies.append(Movie(
//                title: "Movie \(movies.count + 1)",
//                poster_path: "https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", release_date: ""
//            ))
//        }
        
        serialQueue.async { [self] in
            getMoviesFromAPI()
        }
        
        DispatchQueue.main.async {
            print(self.discoverMovies)
            
            self.collectionView.reloadData()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        
        collectionView.register(MovieCardCollectionViewCell.self, forCellWithReuseIdentifier: MovieCardCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
//        appendData()
        
        vm.fetchPopularMoviesData {
            print("on fetch data")
            self.collectionView.reloadData()
            self.discoverMovies.results = self.vm.discoverMovies
        }
       
        
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
//            appendData()
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
