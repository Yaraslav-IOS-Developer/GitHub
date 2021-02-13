//
//  NetworkService.swift
//  GitHub
//
//  Created by Yaroslav on 3.02.21.
//

import Foundation
import UIKit


class NetworkService {
    
   static let shared = NetworkService()
    
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
    
    func fetchImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else  { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
        
    }
    
    
    func fetchUserDetails(url: String, completion: @escaping(UserDetails?) -> Void   ) {
        
        let stringUrl = URL(string: url)
        guard let url = stringUrl else { return }
        completion(nil)
        
        URLSession.shared.dataTask(with: url) { (data, respanse, error) in
            guard let data = data else { return }
            completion(nil)
            do {
                let users = try JSONDecoder().decode(UserDetails.self, from: data)
                completion(users)
                
            } catch let jsonError {
                print("Faild to decode JSON,", jsonError)
                completion(nil)
            }
        }.resume()
    }
}
