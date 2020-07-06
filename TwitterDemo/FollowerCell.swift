//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Jesus Rios on 6/30/20.
//  Copyright © 2020 Utensils Inc. All rights reserved.
//

import Foundation
import UIKit

class FollowerCell: UICollectionViewCell {

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func fetchImg(imgUrl: String) {
        guard let url = URL(string: imgUrl) else {
            print("error with url")
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profile.image = img
                    }
                }
            }
        }
    }
    
}
