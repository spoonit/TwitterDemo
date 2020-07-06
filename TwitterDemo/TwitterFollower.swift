//
//  TwitterFollower.swift
//  TwitterDemo
//
//  Created by Jesus Rios on 7/3/20.
//  Copyright © 2020 Utensils Inc. All rights reserved.
//

import Foundation
import Swifter

class TwitterFollower {
    var profileImg : String
    var name : String
    var description : String
    
    init(json: [String: Any]) {
        profileImg = ""
        name = ""
        description = ""
    }
    
}
