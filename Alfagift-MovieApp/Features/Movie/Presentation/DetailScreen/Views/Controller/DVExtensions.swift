//
//  MISTableViewExtension.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 06/02/23.
//

import Foundation
import UIKit

extension MovieInfoScreenViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count == 0 ? 1 :
        self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.id, for: indexPath) as! ReviewCell
        if self.reviews.count == 0 || self.reviews[indexPath.row].authorDetails?.avatarPath == nil {
            cell.iconImage.image = UIImage(systemName: personLogoStr)
        }else{
            cell.iconImage.load(
                url: URL(
                    string: imageBaseUrl
                            + (self.reviews[indexPath.row].authorDetails?.avatarPath)!
                          )!
                )
        }
        cell.titleLabel.text = self.reviews.count > 0 ? self.reviews[indexPath.row].author : noReviewMessage
        cell.descLabel.text = self.reviews.count > 0 ? self.reviews[indexPath.row].content : noReviewMessage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return reviewHeader
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.reviews.count - 1 && vm.getConnectionStatus() {
            vm.setNextPageReview()
            vm.getMovieReviewsFromAPI(id: self.movieID!){
                self.reviews.append(contentsOf: self.vm.getReviews())
                self.tableview.reloadData()
            }
        }
    }

    
}
