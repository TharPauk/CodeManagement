//
//  UpcomingMovieCell.swift
//  CodeManagement
//
//  Created by Min Thet Maung on 25/05/2022.
//

import UIKit
import SDWebImage

class UpcomingMovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var heartIcon: UIImageView!
    @IBOutlet weak var voteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
    }
    
    func setData(movie: MovieData) {
        if let postPath = movie.posterPath,
           let url = URL(string: "\(EndPoint.imageUrl)/\(postPath)") {
            movieImage.sd_setImage(with: url)
        }
        movieTitleLabel.text = movie.title
        movieOverviewLabel.text = movie.overview
        voteLabel.text = "\(String(describing: movie.voteAverage))%"
        
    }
}
