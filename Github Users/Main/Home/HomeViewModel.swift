//
//  HomeViewModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation
import Combine

class HomeViewModel {
    
    private var userServiceFileManager = UserServiceFileManager.instance
    var manager: UserModelFileManager = UserModelFileManager.instance
    private var userStoredData: [String] = []
    
    var counter: Int = 0
    @Published var userCellViewModels = [UserCellImageDownloader]()
    @Published var userProfiles = [UserModel]()
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    let userService: GithubUserAPIProtocol = UserService()
    var isPaginating: Bool = false
    
    init() {
        getSavedData()
        
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
    
    func getSavedData() {
        userServiceFileManager.$storedData
            .receive(on: RunLoop.main)
            .sink { [weak self] storeValue in
                guard let self = self else { return }
                self.userStoredData = storeValue
            }
            .store(in: &subscriptions)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else {
                return
            }
            if self.userStoredData.isEmpty {
                self.fetchData()
            } else {
                for imageKey in self.userStoredData {
                    if let userData = self.manager.getCahce(key: imageKey) {
                        print("Getting saved image! \(userData)")
                        let userData = UserModel(id: Double(userData.id) ?? 0, username: userData.username, avatar: nil, userType: userData.userType)
                        self.userProfiles.append(userData)
                    }
                }
            }
        }
    }
}
