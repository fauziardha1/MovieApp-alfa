//
//  MainViewController.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 05/01/23.
//

import Foundation
import UIKit


class MainViewController : UIViewController {
    
    var discoverMovies : DiscoverMovie = DiscoverMovie(page: 0, results: [], totalPages: 0, totalResults: 0)
    var vm = MovieViewModel()
    private let refreshControl = UIRefreshControl()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = mainViewTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.register(MovieCardCollectionViewCell.self, forCellWithReuseIdentifier: MovieCardCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
        self.prepareData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func prepareData()  {
        vm.fetchDiscoverMoviesData { [self] in
            self.collectionView.reloadData()
            self.discoverMovies.results = self.vm.discoverMovies
        }
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        vm.fetchDiscoverMoviesData { [self] in
            self.discoverMovies.results = self.vm.discoverMovies
            self.collectionView.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if discoverMovies.results.count == 0 {
            self.collectionView.setEmptyMessage(emptyMessage)
        }else{
            self.collectionView.restore()
        }
        return discoverMovies.results.count
    }
    
}
