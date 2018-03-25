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

class RSearchUserTableViewController: UITableViewController,UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RSearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RSearchTableViewCell", for: indexPath) as! RSearchTableViewCell
        cell.textLabel?.text = "Sample"
        return cell
    }

    // TODO - Remove the following
    @IBAction func testButtonClicked(_ sender: Any) {
        NetworkManager.shared.userListingApi(searchString: "tom", pageNumber: 1)
    }
    
}
