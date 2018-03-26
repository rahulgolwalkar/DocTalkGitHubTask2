//
//  RSearchUserTableViewController.swift
//  DocTalkGitHubTask
//
//  Created by rahulg on 25/03/18.
//  Copyright © 2018 rahulg. All rights reserved.
//

import UIKit

class RSearchUserTableViewController: UITableViewController {

    var userArray:[User] = [User]()
    var pageNumber = 1
    var moreUsersAvailable = false
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RSearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RSearchTableViewCell", for: indexPath) as! RSearchTableViewCell
        let userObject: User = userArray[indexPath.row]
        cell.textLabel?.text = userObject.login
        if ((indexPath.row == userArray.count - 1) && moreUsersAvailable) {
            loadMoreUsers()
        }
        return cell
    }
    
    // MARK - Scroll View
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    func loadMoreUsers() {
        if userArray.count < 30 {
            print("avoiding any unexpected fallthroughs")
            return
        }
        pageNumber += 1
        NetworkManager.shared.userListingApi(searchString: searchBar.text!, pageNumber: pageNumber, successCH: { (userListingApi) in
            self.userArray.append(contentsOf: userListingApi.items)
            self.tableView.reloadData()
        }) { (errorMessage) in
            let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK - Search Bar delegate
extension RSearchUserTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 1 {
            return
        }
        self.userArray.removeAll()
        self.pageNumber = 1
        self.activityIndicator.startAnimating()
        NetworkManager.shared.userListingApi(searchString: searchText, pageNumber: pageNumber, successCH: { (userListingApi) in
            self.userArray.append(contentsOf: userListingApi.items)
            self.tableView.reloadData()
            self.moreUsersAvailable = true
            if (userListingApi.items.count < 30) {
                self.activityIndicator.stopAnimating()
                self.moreUsersAvailable = false
            }
            
        }) { (errorMessage) in
            let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.activityIndicator.stopAnimating()
        }
    }
    
}




