//
//  MovieGridDetailsViewController.swift
//  Flix
//
//  Created by Karina Zhang on 10/2/20.
//  Copyright © 2020 Codepath. All rights reserved.
//
import UIKit
import AlamofireImage
class MovieGridDetailsViewController: UIViewController {
    var movie: [String:Any]!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af_setImage(withURL: backdropUrl!)
        
        view.bringSubviewToFront(posterView)
        view.bringSubviewToFront(titleLabel)
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movieID = movie["id"] as! Int
    
    }

}
