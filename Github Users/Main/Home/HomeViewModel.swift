//
//  HomeViewModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation
import Combine

class HomeViewModel {
    
    var counter: Int = 0
    @Published var userCellViewModels = [UserCellViewModel]()
    @Published var userProfiles = [UserModel]()
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    let userService: GithubUserAPIProtocol = UserService()
    var isPaginating: Bool = false
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard userProfiles.count < 890 else { return }
        let endpoint = (userProfiles.count / 30) + 1
        userService.fetchData(endpoint: String(endpoint))
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                print(completion)
                self?.counter = 0
            } receiveValue: { [weak self] model in
                self?.userProfiles.append(contentsOf: model)
                print("The result from the network call is: \(model)")
            }
            .store(in: &subscriptions)

    }
    
    func paginating() {
        print("Checking number of times this is called")
            fetchData()
    }
}
