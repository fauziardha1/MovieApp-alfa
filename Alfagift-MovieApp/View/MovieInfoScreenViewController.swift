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
        label.numberOfLines = 100
        return label
    }()
    
    lazy var backgroundImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var posterImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    lazy var movieTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var movieGenre : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = ""
        return label
    }()
    
    lazy var movieGenreLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = "Genre\t"
        return label
    }()
    
    lazy var genreHV : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieGenreLabel)
        view.addSubview(movieGenre)
        
        NSLayoutConstraint.activate([
            movieGenreLabel.topAnchor.constraint(equalTo: view.topAnchor),
            movieGenreLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            movieGenre.leftAnchor.constraint(equalTo: movieGenreLabel.rightAnchor),
            movieGenre.topAnchor.constraint(equalTo: view.topAnchor),
            movieGenre.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        return view
    }()
    
    
    lazy var titleSection : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(posterImage)
        view.addSubview(movieTitle)
        view.addSubview(genreHV)
        
        NSLayoutConstraint.activate([
            posterImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            posterImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -75),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            posterImage.heightAnchor.constraint(equalToConstant: 150),
            
            movieTitle.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 12),
            movieTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: -12),
            movieTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            
            genreHV.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            genreHV.leftAnchor.constraint(equalTo: movieTitle.leftAnchor),
            genreHV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            genreHV.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/9),
        ])
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(backgroundImage)
        view.addSubview(titleSection)
        
        
        vm.getMoviesDetailFromAPI(id: self.movieID!) {
            self.label.text = self.vm.getMovieDetailInstance().first?.tagline ?? "Hello"
            var text = ""
            for _ in 1...100{
                text += "hello world! \n"
            }
            self.label.text = text
            self.movieDetail = self.vm.getMovieDetailInstance()
            
            DispatchQueue.main.async {
                self.backgroundImage.load(url: URL(string: self.imageBaseUrl + self.movieDetail.first!.backdropPath!)!)
                
                self.posterImage.load(url: URL(string: self.imageBaseUrl + self.movieDetail.first!.posterPath! )!)
                self.movieTitle.text = self.movieDetail.first!.title
                
                let comma = ","
                var index = 0
                for genre in self.movieDetail.first!.genres! {
                    self.movieGenre.text! += (index > 0 ? comma : "") +  " \(genre.name!)"
                    index += 1
                }
            }
        }
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            titleSection.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            titleSection.leftAnchor.constraint(equalTo: view.leftAnchor),
            
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
