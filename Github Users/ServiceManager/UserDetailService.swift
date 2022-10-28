//
//  UserDetailService.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import Foundation
import Combine

class UserDetailService: GithubUserAPI<GithubUserNetworking>, GithubUserDetailAPIProtocol {
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchData(endpoint: String) -> Future<DetailModel, Error> {
        return Future<DetailModel, Error> {[weak self] promise in
            guard let self = self else { return promise(.failure(NetworkError.unknown))}
            self.fetchData(target: .fetchUserData(endpoint: endpoint), responseClass: DetailModel.self)
                .receive(on: RunLoop.main)
                .sink { completion in
                    print("Completion: \(completion)")
                } receiveValue: { result in
                    let userDetail = result
                    promise(.success(userDetail))
                }
                .store(in: &self.subscriptions)
        }
    }
    
}
