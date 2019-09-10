//
//  User.swift
//  AnimalSpotter
//
//  Created by Vici Shaweddy on 9/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct User: Codable {
    
    // can decode and encode
    let username: String
    let password: String
}
