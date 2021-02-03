//
//  SearshResponse.swift
//  GitHub
//
//  Created by Yaroslav on 2.02.21.
//

import Foundation


struct SearshResponse: Codable {
    
    var total_count: Int
    var incomplete_results: Bool
    var items: [User]
  
}

struct User: Codable {
    var login: String
    var type: String
}


