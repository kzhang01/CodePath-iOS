//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Karina Zhang on 10/5/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeTweet(_ sender: Any) {
        let toBeLiked = !favorited
        if (toBeLiked) {
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId, success: {
                self.setFavorited(true)
            }, failure: { (error) in
                print("Like failed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unlikeTweet(tweetId: tweetId, success: {
                self.setFavorited(false)
            }, failure: { (error) in
                print("Unlike failed: \(error)")
            })
        }
    }
    @IBAction func retweet(_ sender: Any) {
    }
    
    var tweetId:Int = -1
    var favorited:Bool = false
    
    func setFavorited(_ isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
