//
//  SearchTableViewController.swift
//  GitHub
//
//  Created by Yaroslav on 2.02.21.
//

import UIKit


class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    var searshResponse: SearshResponse! = nil
    let searchController = UISearchController(searchResultsController: nil)
    
    private var timer: Timer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        
    }
    
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search user GutHub"
        
    }
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searshResponse?.items.count ?? 0
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let users = searshResponse?.items[indexPath.row]
        cell.nameLabel.text = users?.login
        cell.typeLabel.text = users?.type
        cell.urlLabel.text = users?.url
        NetworkService.shared.fetchImage(url: (users?.avatar_url)!) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                   currentIndexPath != indexPath {
                    return
                }
                cell.avatarImage.image = image
                cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.size.height / 2
                cell.avatarImage.clipsToBounds = true
            }
        }
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let data = searshResponse?.items else { return }
//        print(data[indexPath.row])
//    }
        
   
    

    
     // MARK: - Navigation
     
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "DetailSegue" else { return }
        let controller = segue.destination as! DetailViewController
        let index = tableView.indexPathForSelectedRow!.row
        
        let users = searshResponse.items[index]
        controller.users = users
             
     }
     
}
extension SearchTableViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://api.github.com/search/users?page=1&q=\(searchText)"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            NetworkService.shared.requst(urlString: urlString) { [weak self](result) in
                switch result {
                case .success(let searshResponse):
                    self?.searshResponse = searshResponse
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
