//
//  UserService.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation
import Combine

class UserService: GithubUserAPI<GithubUserNetworking>, GithubUserAPIProtocol {
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchData(endpoint: String) -> Future<[UserModel], Error> {
        return Future<[UserModel], Error> {[weak self] promise in
            guard let self = self else { return promise(.failure(NetworkError.unknown))}
            self.fetchData(target: .fetchUserData(endpoint: endpoint), responseClass: GithubUserModel.self)
                .receive(on: RunLoop.main)
                .sink { completion in
                    print("Completion: \(completion)")
                } receiveValue: { result in
                    let userProfile = result.items
                    promise(.success(userProfile))
                }
                .store(in: &self.subscriptions)
        }
    }
    
}
