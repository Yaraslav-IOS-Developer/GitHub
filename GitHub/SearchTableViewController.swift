//
//  SearchTableViewController.swift
//  GitHub
//
//  Created by Yaroslav on 2.02.21.
//

import UIKit

class SearchTableViewController: UITableViewController {

    let networkService = NetworkService()
    let sesrchController = UISearchController(searchResultsController: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        let urlString = "https://api.github.com/search/users?page=1&q=Yarosalv"
        networkService.requst(urlString: urlString) { (result) in
            switch result {
            case .success(let searshResponse):
                searshResponse.items.map { (users) in
                    print(users.login)
                }
            case .failure(let error):
                print(error)
            }
        }
       
    }
    
    
    private func setupSearchBar() {
        navigationItem.searchController = sesrchController
        sesrchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        sesrchController.obscuresBackgroundDuringPresentation = false
    }
    
    

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 3
           
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "123"
        

        return cell
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
