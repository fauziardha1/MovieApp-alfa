//
//  MovieInfoScreenViewController.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 06/01/23.
//

import UIKit

class MovieInfoScreenViewController: UIViewController {
    
    private var movieID : Int?
    private var currentMovie : Film?
    private var vm = MovieViewModel()
    
    var movieDetail = [MovieDetail]()
    
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    func setMovieID(_ id : Int )  {
        self.movieID = id
    }
    
    func getMovieID() -> Int? {
        self.movieID
    }
    
    func setCurrentMovie(_ movie : Film)  {
        self.currentMovie = movie
    }
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var backgroundImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(backgroundImage)
        
        vm.getMoviesDetailFromAPI(id: self.movieID!) {
            self.label.text = self.vm.getMovieDetailInstance().first?.tagline ?? "Hello"
            self.movieDetail = self.vm.getMovieDetailInstance()
            
            DispatchQueue.main.async {
                self.backgroundImage.load(url: URL(string: self.imageBaseUrl + self.movieDetail.first!.backdropPath!)!)
            }
        }
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
        ])
        
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

#if DEBUG
import SwiftUI
struct MovieInfoScreenController_Preview : PreviewProvider {
    static var previews: some View{
        ViewControllerPreview {
            MovieInfoScreenViewController()
        }
    }
}


#endif
