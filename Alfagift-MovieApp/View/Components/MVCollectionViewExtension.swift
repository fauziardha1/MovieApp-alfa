//
//  MVTableExtension.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 06/02/23.
//

import Foundation
import UIKit

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        if indexPath.row == discoverMovies.results.count - 1 && vm.getConnectionStatus() {
            vm.setNextpage()
            vm.fetchDiscoverMoviesData {
                self.discoverMovies.results.append(contentsOf: self.vm.discoverMovies)
                collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieInfoVC = MovieInfoScreenViewController()
        movieInfoVC.setMovieID(self.discoverMovies.results[indexPath.row].id!)
        movieInfoVC.setCurrentMovie(self.discoverMovies.results[indexPath.row])
        
        self.navigationController?.pushViewController(movieInfoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return cvGap
    }
}
