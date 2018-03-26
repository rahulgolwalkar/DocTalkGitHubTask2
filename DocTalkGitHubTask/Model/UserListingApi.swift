//
//  UserListingApi.swift
//  DocTalkGitHubTask
//
//  Created by rahulg on 25/03/18.
//  Copyright © 2018 rahulg. All rights reserved.
//

import Foundation

struct UserListingApi: Codable {
    var total_count: Int?
    var incomplete_results: Bool
    var items: [User]
}
