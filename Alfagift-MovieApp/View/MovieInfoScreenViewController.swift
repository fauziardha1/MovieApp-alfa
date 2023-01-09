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
    
    let backgroundImage : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
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
        view.backgroundColor = .systemBlue
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
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemYellow
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return view
    }()
    
    func setupScrollView(){
        // set scrollview as main layer
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            // set position of scroll view
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // set contentview
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    func setupContentView(){
        contentView.addSubview(label)
        contentView.addSubview(backgroundImage)
        contentView.addSubview(titleSection)
        
        NSLayoutConstraint.activate([
            // set content of inside contentView
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            
            titleSection.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            titleSection.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        // setup scrollview
//        setupScrollView()
        
        //setup contentView
//        setupContentView()
        
//        vm.getMoviesDetailFromAPI(id: self.movieID!) {
//            self.label.text = self.vm.getMovieDetailInstance().first?.tagline ?? "Hello"
//            var text = ""
//            for _ in 1...100{
//                text += "hello world! \n"
//            }
//            self.label.text = text
//            self.movieDetail = self.vm.getMovieDetailInstance()
//
//            DispatchQueue.main.async {
//                self.backgroundImage.load(url: URL(string: self.imageBaseUrl + self.movieDetail.first!.backdropPath!)!)
//
//                self.posterImage.load(url: URL(string: self.imageBaseUrl + self.movieDetail.first!.posterPath! )!)
//                self.movieTitle.text = self.movieDetail.first!.title
//
//                let comma = ","
//                var index = 0
//                for genre in self.movieDetail.first!.genres! {
//                    self.movieGenre.text! += (index > 0 ? comma : "") +  " \(genre.name!)"
//                    index += 1
//                }
//            }
//        }
        
        
        // test scroll view
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.widthAnchor.constraint(equalTo:view.widthAnchor),
        ])
        
        setupScrollViews()
        setupViews()
        
        
    }
    
    // start coba2
    func setupScrollViews() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Lorem\n ipsum dolor sit amet,\n consectetur adipiscing elit, sed do\n eiusmod tempor incididunt ut labore\n et dolore magna aliqua. Ut enim\n ad minim veniam, quis\n nostrud exercitation ullamco laboris nisi\n ut aliquip ex ea commodo consequat.\n Duis aute irure dolor\n in reprehenderit in voluptate velit esse\n cillum dolore eu fugiat nulla\n pariatur. Excepteur sint\n occaecat cupidatat non proident, sunt in\n culpa qui officia deserunt mollit\n anim id\nf est laborum."
            label.numberOfLines = 0
            label.sizeToFit()
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let subtitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Sed ut perspiciatis\n unde omnis iste natus error sit\n voluptatem accusantium doloremque laudantium, totam \nrem aperiam,\n eaque ipsa quae ab illo inventore\n veritatis et quasi architecto beatae vitae dicta\n sunt explicabo.\n Nemo enim ipsam voluptatem quia\n voluptas sit aspernatur aut odit aut fugit, sed quia\n consequuntur magni \ndolores eos qui ratione\n voluptatem sequi nesciunt. Neque porro \nquisquam est, qui dolorem ipsum quia\n dolor sit amet, consectetur,\n adipisci velit, sed quia non numquam\n eius modi tempora incidunt ut labore \net dolore\n magnam aliquam quaerat voluptatem. Ut enim \nad minima veniam, quis nostrum exercitationem\n ullam\n corporis suscipit laboriosam, nisi ut\n aliquid ex ea commodi consequatur? Quis autem vel eum\n iure reprehenderit\n qui in ea voluptate velit\n esse quam nihil molestiae consequatur, vel illum qui\n dolorem eum\n fugiat quo voluptas nulla\n pariatur?"
            label.numberOfLines = 0
            label.sizeToFit()
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
//    let image: UIImageView
        
        func setupViews(){
            
//            backgroundImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
            backgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            contentView.addSubview(backgroundImage)
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//            backgroundImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
            
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = false
            
            contentView.addSubview(titleLabel)
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            titleLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor).isActive = true
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
            contentView.addSubview(subtitleLabel)
            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
    //end coba coba
    

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
