//
//  GithubUserAPIEndpoint.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation
enum GithubUserAPIEndpoint {
    case development
    case allUser
    
    
    var API: String {
        switch self {
        case .development:
            return "https://api.github.com"
        case .allUser:
            return "/search/users?q=lagos&page="
        }
    }
}
