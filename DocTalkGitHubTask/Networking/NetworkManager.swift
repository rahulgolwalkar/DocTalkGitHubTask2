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
    let baseURL = "https://api.github.com/"
    
    
    // https://api.github.com/search/users?q=tom&sort=followers&page=1&per_page=30&client_id=3825adf659cb6dcfe5ef&client_secret=9234a5ac5727ae8b0dd89b4f60c632da38118fcd

    
    func userListingApi(searchString: String, pageNumber: Int, successCH:@escaping (_ userListingApi: UserListingApi) -> Void, failureCH:@escaping (_ errorMessage: String) -> Void) {
        let completeUrl: URL = URL(string: baseURL + "search/users")!
        let params: Parameters = [
            "q": searchString,
            "sort": "followers",
            "page": pageNumber,
            "per_page": 1, //30 // TODO - change this
            "client_id": "3825adf659cb6dcfe5ef",
            "client_secret": "9234a5ac5727ae8b0dd89b4f60c632da38118fcd"
        ]
        Alamofire.request(completeUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON {
            (response:DataResponse<Any>) in
            switch (response.result) {
            case .success:
                if response.result.value != nil {
                    do {
                        let photoObject =  try JSONDecoder().decode(UserListingApi.self, from: response.data!)
                        successCH(photoObject)
                    } catch {
                        failureCH(error.localizedDescription)
                    }
                } else {
                    print("Got no data")
                    failureCH("No data")
                }
                break
            case .failure:
                print(response.result.error?.localizedDescription ?? "Unknown Error")
                break
            }
            
        }
    }

}
