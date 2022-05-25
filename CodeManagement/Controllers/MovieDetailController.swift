//
//  MovieDetailController.swift
//  CodeManagement
//
//  Created by Min Thet Maung on 25/05/2022.
//

import UIKit

class MovieDetailController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    private var movie: MovieData!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let postPath = movie.posterPath,
           let url = URL(string: "\(EndPoint.imageUrl)/\(postPath)") {
            movieImage.sd_setImage(with: url)
        }
        movieTitle.text = movie.title
    }
    

    func setData(movie: MovieData) {
        self.movie = movie
    }
}
