//
//  UserDetails.swift
//  GitHub
//
//  Created by Yaroslav on 08.02.2021.
//

import Foundation



struct UserDetails: Codable {
    
    var name: String
    var login: String
    var avatar_url: URL
    var url: URL
    
}
