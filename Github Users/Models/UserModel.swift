//
//  UserModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation

struct GithubUserModel: Codable {
    let results: [UserModel]
}
struct UserModel: Codable {
    let username: String
}
