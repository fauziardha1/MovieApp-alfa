//
//  MovieInfoScreenViewController.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 06/01/23.
//

import UIKit
import YouTubePlayerKit

class MovieInfoScreenViewController: UIViewController {
    
    var movieID : Int?
    private var currentMovie : Film?
    var vm = DetailViewModel()
    var movieDetail = [MovieDetail]()
    var reviews = [Item]()
    var trailerURL = ""
    
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
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    lazy var posterImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(systemName: "lanyardcard.fill")
        return imageView
    }()
    lazy var movieTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
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
    
    lazy var movieDuration : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = ""
        return label
    }()
    
    lazy var movieDurationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = "Duration\t"
        return label
    }()
    
    lazy var durationHV : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieDurationLabel)
        view.addSubview(movieDuration)
        
        NSLayoutConstraint.activate([
            movieDurationLabel.topAnchor.constraint(equalTo: view.topAnchor),
            movieDurationLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            movieDuration.leftAnchor.constraint(equalTo: movieDurationLabel.rightAnchor),
            movieDuration.topAnchor.constraint(equalTo: view.topAnchor),
            movieDuration.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        return view
    }()
    
    lazy var movieRate : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = ""
        return label
    }()
    
    lazy var movieRateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = "Rate\t\t"
        return label
    }()
    
    lazy var rateHV : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieRateLabel)
        view.addSubview(movieRate)
        
        NSLayoutConstraint.activate([
            movieRateLabel.topAnchor.constraint(equalTo: view.topAnchor),
            movieRateLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            movieRate.leftAnchor.constraint(equalTo: movieRateLabel.rightAnchor),
            movieRate.topAnchor.constraint(equalTo: view.topAnchor),
            movieRate.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        return view
    }()
    
    
    lazy var titleSection : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(posterImage)
        view.addSubview(movieTitle)
        view.addSubview(genreHV)
        view.addSubview(durationHV)
        view.addSubview(rateHV)
        
        NSLayoutConstraint.activate([
            posterImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            posterImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            posterImage.heightAnchor.constraint(equalToConstant: 120),
            
            movieTitle.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 12),
            movieTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: -24),
            movieTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            
            genreHV.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            genreHV.leftAnchor.constraint(equalTo: movieTitle.leftAnchor),
            genreHV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            genreHV.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/9),
            
            durationHV.topAnchor.constraint(equalTo: genreHV.bottomAnchor,constant: 32),
            durationHV.leftAnchor.constraint(equalTo: genreHV.leftAnchor),
            durationHV.rightAnchor.constraint(equalTo: genreHV.rightAnchor),
            
            rateHV.topAnchor.constraint(equalTo: durationHV.bottomAnchor,constant: 16),
            rateHV.leftAnchor.constraint(equalTo: durationHV.leftAnchor),
            rateHV.rightAnchor.constraint(equalTo: durationHV.rightAnchor),
        ])
        
        return view
    }()
    
    lazy var overviewTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var overviewContent : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.numberOfLines = 100
        label.font = label.font.withSize(16)
        label.textColor = .systemGray
        return label
    }()
    
    // overview section
    lazy var overviewSection : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(overviewTitle)
        view.addSubview(overviewContent)
        view.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            overviewTitle.topAnchor.constraint(equalTo: view.topAnchor),
            overviewTitle.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            overviewContent.topAnchor.constraint(equalTo: overviewTitle.bottomAnchor),
            overviewContent.leftAnchor.constraint(equalTo: overviewTitle.leftAnchor),
            overviewContent.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 24)
        ])
        
        return view
    }()
    
    func setText(){
        // set duration
        self.movieDuration.text = String((self.movieDetail.first?.runtime)!) + " minutes"
        
        // set rate
        self.movieRate.text = String((self.movieDetail.first!.voteAverage)!) + " (" + String(self.movieDetail.first!.voteCount!) + " Vote)"
        
        // set overview
        self.overviewContent.text = self.movieDetail.first?.overview ?? "overview"
    }
    
    // tableview instance
    let tableview : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .darkGray.withAlphaComponent(0.1)
        return tv
    }()
    
    lazy var buttonPlay : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    @objc func buttonPressed(){
        let player : YouTubePlayer = YouTubePlayer(
            source: .video(id: self.trailerURL),
            configuration: .init(autoPlay: true)
        )
        let youTubePlayerViewController = YouTubePlayerViewController(player: player)
        self.present(youTubePlayerViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(label)
        view.addSubview(backgroundImage)
        view.addSubview(titleSection)
        view.addSubview(overviewSection)
        view.addSubview(buttonPlay)
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.id)
        overviewSection.addSubview(tableview)
        
        
        
        self.prepareConstraint()
        
        // when no internet connection
        if vm.getConnectionStatus() == false{
            noConnectionView()
        }else{
            self.prepareData()
        }
        
    }
    
    
    func noConnectionView(){
        // background image placeholder
        self.backgroundImage.image = UIImage(systemName: photoImgStr)
        self.backgroundImage.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.backgroundImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        // poster placeholder
        posterImage.tintColor = .white
        
        // genre
        self.movieGenre.text = noDataMessage
        
        // duration
        self.movieDuration.text = noDataMessage
        
        // rate
        self.movieRate.text = String(self.currentMovie?.voteAverage ?? 0) + " (" + String(self.currentMovie?.voteCount ?? 0) + " vote)"
        
        // overview
        self.overviewContent.text = noOverviewMessage
        
        // button plat
        self.buttonPlay.setBackgroundImage(UIImage(systemName: playLogoStr), for: .normal)
        self.buttonPlay.isEnabled = false
        
        // set title
        self.movieTitle.text = self.currentMovie?.title ?? titleStr
    }
    
    func prepareConstraint(){
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            buttonPlay.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            buttonPlay.centerYAnchor.constraint(equalTo: backgroundImage.centerYAnchor),
            
            titleSection.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            titleSection.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleSection.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleSection.heightAnchor.constraint(equalToConstant: 0),
            
            overviewSection.topAnchor.constraint(equalTo: titleSection.bottomAnchor,constant: 100),
            overviewSection.leftAnchor.constraint(equalTo: titleSection.leftAnchor, constant: 12),
            overviewSection.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 24),
            overviewSection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableview.bottomAnchor.constraint(equalTo: overviewSection.bottomAnchor),
            tableview.leftAnchor.constraint(equalTo: overviewSection.leftAnchor),
            tableview.rightAnchor.constraint(equalTo: overviewSection.rightAnchor),
            tableview.topAnchor.constraint(equalTo: overviewContent.bottomAnchor, constant: 12),
        ])
    }
    
    func prepareData(){
        vm.getMoviesDetailFromAPI(id: self.movieID!) {
            self.movieDetail = self.vm.getMovieDetailInstance()
            print(self.movieDetail)
            
            DispatchQueue.main.async {
                if self.movieDetail.first?.backdropPath == nil || self.vm.getConnectionStatus() == false {
                    self.backgroundImage.image = UIImage(systemName: photoImgStr)
                    self.backgroundImage.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
                    self.backgroundImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
                }else{
                    self.backgroundImage.load(url: URL(string: imageBaseUrl + self.movieDetail.first!.backdropPath!)!)
                }
                
                self.posterImage.load(url: URL(string: imageBaseUrl + self.movieDetail.first!.posterPath! )!)
                self.movieTitle.text = self.movieDetail.first!.title
                var index = 0
                self.movieGenre.numberOfLines = (self.movieDetail.first?.genres?.count ?? 0 ) > 1 ? 2 : 1
                
                for genre in self.movieDetail.first!.genres! {
                    self.movieGenre.text! += (index > 0 ? comma : "") +  " \(genre.name!)"
                    index += 1
                }
                self.setText()
            }
            
            
        }
        
        vm.getMovieReviewsFromAPI(id: self.movieID!) { [self] in
            self.tableview.reloadData()
            DispatchQueue.main.async {
                self.tableview.reloadData()
                self.reviews = self.vm.getReviews()
                self.tableview.reloadData()
            }
        }
        
        vm.getMovieTrailerFromAPI(id: self.movieID!) {
            DispatchQueue.main.async {
                self.trailerURL = self.vm.getTrailerURL()
            }
        }
    }

}
