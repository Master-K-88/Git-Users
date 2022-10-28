//
//  UserModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation

struct GithubUserModel: Codable {
    let items: [UserModel]
}
struct UserModel: Identifiable, Codable {
    let id: Double
    let username: String?
    let avatar: String?
    let userType: String?
    let userInfo: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "login"
        case avatar = "avatar_url"
        case userType = "type"
        case userInfo = "url"
    }
}
