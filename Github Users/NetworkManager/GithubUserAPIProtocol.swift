//
//  GithubUserAPIProtocol.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation
import Combine

protocol GithubUserAPIProtocol {
    func fetchData(endpoint: String) -> Future<UserModel, Error>
}
