//
//  RNetworkManager.swift
//  DocTalkGitHubTask
//
//  Created by rahulg on 25/03/18.
//  Copyright © 2018 rahulg. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    // MARK: - Properties
    
    
    static let shared = NetworkManager()
    let baseURL: URL
    
    
    // Initialization
    
//    private init(baseURL: URL) {
//        self.baseURL = baseURL
//    }
    
    init() {
        self.baseURL = URL(fileURLWithPath: "https://api.github.com/")
    }
    
    func userListingApi() {
        
    }

}
