//
//  DetailViewController.swift
//  GitHub
//
//  Created by Yaroslav on 05.02.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var users: User!
    var userDetails: UserDetails!
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        NetworkService.shared.fetchUserDetails(url: users.url) { (userDetails) in
            guard let userDetails = userDetails else { return }
            
            DispatchQueue.main.async {
                self.nameLabel.text = userDetails.name
                self.loginLabel.text = userDetails.login
            }
        }

        NetworkService.shared.fetchImage(url: (users?.avatar_url)!) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.myImage.image = image
                self.myImage.layer.cornerRadius = self.myImage.frame.size.height / 2
                self.myImage.clipsToBounds = true
                
            }
        }

    }
}
