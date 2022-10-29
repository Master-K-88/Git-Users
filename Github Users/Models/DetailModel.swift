//
//  DetailModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import Foundation

struct DetailModel: Codable, UserDetailDataProtocol {
    var id: Double
    var username: String = ""
    var avatar: String = ""
    var userType: String = ""
    var userInfo: String = ""
    var location: String = ""
    var fullName: String = ""
    var company: String = ""
    var bio: String = ""
    var email: String = ""
    var twitter: String = ""
    var favourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "login"
        case avatar = "avatar_url"
        case userType = "type"
        case userInfo = "url"
        case location = "location"
        case fullName = "name"
        case company = "company"
        case bio = "bio"
        case email = "email"
        case twitter = "twitter_username"
    }
}

//{
//  "login": "lagos",
//  "id": 974313,
//  "node_id": "MDQ6VXNlcjk3NDMxMw==",
//  "avatar_url": "https://avatars.githubusercontent.com/u/974313?v=4",
//  "gravatar_id": "",
//  "url": "https://api.github.com/users/lagos",
//  "html_url": "https://github.com/lagos",
//  "followers_url": "https://api.github.com/users/lagos/followers",
//  "following_url": "https://api.github.com/users/lagos/following{/other_user}",
//  "gists_url": "https://api.github.com/users/lagos/gists{/gist_id}",
//  "starred_url": "https://api.github.com/users/lagos/starred{/owner}{/repo}",
//  "subscriptions_url": "https://api.github.com/users/lagos/subscriptions",
//  "organizations_url": "https://api.github.com/users/lagos/orgs",
//  "repos_url": "https://api.github.com/users/lagos/repos",
//  "events_url": "https://api.github.com/users/lagos/events{/privacy}",
//  "received_events_url": "https://api.github.com/users/lagos/received_events",
//  "type": "User",
//  "site_admin": false,
//  "name": "Michalis Lagos",
//  "company": null,
//  "blog": "",
//  "location": null,
//  "email": null,
//  "hireable": null,
//  "bio": null,
//  "twitter_username": null,
//  "public_repos": 2,
//  "public_gists": 0,
//  "followers": 0,
//  "following": 0,
//  "created_at": "2011-08-11T16:36:48Z",
//  "updated_at": "2021-09-09T22:43:42Z"
//}
