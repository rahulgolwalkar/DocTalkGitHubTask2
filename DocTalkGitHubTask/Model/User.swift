//
//  User.swift
//  DocTalkGitHubTask
//
//  Created by rahulg on 25/03/18.
//  Copyright © 2018 rahulg. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var id: Int
    var url: String
    var followers_url: String
}
