//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Karina Zhang on 9/30/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        configureUI()
        networkRequest()
        
        
    }
    
    func networkRequest() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
                
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.collectionView.reloadData()

           }
        }
        task.resume()
    }
    
    func configureUI() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4

        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2)/3
        layout.itemSize = CGSize(width: width, height: width*3/2)
    
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("I'm about to change screens")
        let cell = sender as! MovieGridCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let detailsViewController = segue.destination as! MovieGridDetailsViewController
        detailsViewController.movie = movie
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}
