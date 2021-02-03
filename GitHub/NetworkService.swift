//
//  NetworkService.swift
//  GitHub
//
//  Created by Yaroslav on 3.02.21.
//

import Foundation


class NetworkService {
    
    func requst(urlString: String, completion: @escaping (Result<SearshResponse, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Some erro")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                do {
                    let users = try JSONDecoder().decode(SearshResponse.self, from: data)
                    
                    completion(.success(users))
                    
                } catch let jsonError {
                    print("Faild to decode JSON,", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
        
    }
}
