//
//  GithubUserAPIEndpoint.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation
enum GithubUserAPIEndpoint {
    case development
    
    var API: String {
        switch self {
        case .development:
            return "https://api.github.com/search/users?q=lagos&page="
        }
    }
}
