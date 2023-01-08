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
        
        vm.fetchDiscoverMoviesData { [self] in
            self.collectionView.reloadData()
            self.discoverMovies.results = self.vm.discoverMovies
            print("hello", self.discoverMovies.results.count)
            print("coredata: ", self.vm.coredataMovieCount())
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if discoverMovies.results.count == 0 {
            self.collectionView.setEmptyMessage("No Movie to show,\n Please check you Internet Connection")
        }else{
            self.collectionView.restore()
        }
        
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
