//
//  SearshResponse.swift
//  GitHub
//
//  Created by Yaroslav on 2.02.21.
//

import Foundation


struct SearshResponse: Codable {
    
    var count: Int
    var result: Bool
    var items: [User]
    
    enum CodingKeys: String, CodingKey {
        case count = "total_count"
        case result = "incomplete_results"
        case items
    }
    
}

struct User: Codable {
    var login: String
    var type: String
    var avatar_url: URL
    var url: String
    
}




