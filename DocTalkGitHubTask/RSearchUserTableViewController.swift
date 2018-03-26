//
//  RSearchUserTableViewController.swift
//  DocTalkGitHubTask
//
//  Created by rahulg on 25/03/18.
//  Copyright © 2018 rahulg. All rights reserved.
//

// GET request to https://api.github.com/search/users?q=tom&sort=followers&page=1&per_page=30&client_id=3825adf659cb6dcfe5ef&client_secret=9234a5ac5727ae8b0dd89b4f60c632da38118fcd 

import UIKit
import Alamofire

class RSearchUserTableViewController: UITableViewController {

    var userArray:[User] = [User]()
    var pageNumber = 1
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RSearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RSearchTableViewCell", for: indexPath) as! RSearchTableViewCell
        let userObject: User = userArray[indexPath.row]
        cell.textLabel?.text = userObject.login
        return cell
    }

    // TODO - Remove the following
    @IBAction func testButtonClicked(_ sender: Any) {
        NetworkManager.shared.userListingApi(searchString: "tom", pageNumber: 1, successCH: {userListing in
            
        }, failureCH: {_ in
            self.activityIndicator.stopAnimating()
        })
    }
    
}

// MARK - Search Bar delegate and other stuff
extension RSearchUserTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userArray.removeAll()
        self.activityIndicator.startAnimating()
        NetworkManager.shared.userListingApi(searchString: searchText, pageNumber: pageNumber, successCH: { (userListingApi) in
            self.userArray.append(contentsOf: userListingApi.items)
            self.tableView.reloadData()
        }) { (errorMessage) in
            let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
}




