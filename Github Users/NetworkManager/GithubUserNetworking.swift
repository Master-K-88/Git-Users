//
//  GithubUserNetworking.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation
enum GithubUserNetworking {
    // Other case can be added here depending on the TASK like (POST and DELETE)
    case fetchUserData(endpoint: String)
}

extension GithubUserNetworking: TargetType {
    
    var path: String {
        switch self {
        case .fetchUserData(let endpoint):
            return endpoint
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchUserData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchUserData:
            return .getRequest
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return GithubUserAPIEndpoint.development.API
        }
    }
}
