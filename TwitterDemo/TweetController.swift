//
//  ViewController.swift
//  TwitterDemo
//
//  Created by Jesus Rios on 6/22/20.
//  Copyright © 2020 Utensils Inc. All rights reserved.
//

import UIKit
import Swifter
import SafariServices

class TweetController: UIViewController, SFSafariViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var swifter = Swifter(consumerKey: "gH5EPwSAJngkmMaXKmL1hneJc", consumerSecret: "vECpae3f2WHgGqOxZAh3wLk5zH5lagACwmiO0XmJq3jUEVLtaT")
    var tokenApproved = false
    
    let reuseId = "followerCell"
    
    var followers : [JSON] = []

    @IBOutlet weak var followerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        followerCollectionView.dataSource = self
        followerCollectionView.delegate = self

        if let url = URL(string: "twitterdemo://") {
            swifter.authorize(withCallback: url, presentingFrom: self, forceLogin: false, safariDelegate: self, success: { (_, _) in
                self.getFollowers()
            }) { (err) in
                print(err)
            }
        }
    }

    func getFollowers() {
        let user = UserTag.screenName("nelscline")

        swifter.getUserFollowers(for: user, cursor: nil, count: 20, skipStatus: false, includeUserEntities: false, success: { (json, prev, next) in
            print(json)
            self.followers = json.array ?? []
            self.followerCollectionView.reloadData()
        }) { (err) in
            print(err)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    //UICollectionView methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! FollowerCell
        let follower = followers[indexPath.row]
        
        cell.name.text = follower["name"].string!
        cell.fetchImg(imgUrl: follower["profile_image_url"].string!)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        //Get window size
        let screenRect = UIScreen.main.bounds

        return CGSize(width: screenRect.width, height: 50.0)
    }

}

