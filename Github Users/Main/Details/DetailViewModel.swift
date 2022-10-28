//
//  DetailViewModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import Foundation
import Combine

class DetailViewModel {
    private var userServiceFileManager = UserServiceFileManager.instance
    var manager: UserModelFileManager = UserModelFileManager.instance
    private var userStoredData: [String] = []
    
    var detailEndpoint: String
    var counter: Int = 0
    @Published var userCellViewModels = [UserCellImageDownloader]()
    @Published var userDetail: DetailModel?
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    let userDetailService: GithubUserDetailAPIProtocol = UserDetailService()
    
    init(endPoint: String) {
        detailEndpoint = endPoint
//        getSavedData()
        fetchData()
        
    }
    
    func fetchData() {
        userDetailService.fetchData(endpoint: detailEndpoint)
            .receive(on: RunLoop.main)
            .sink { completion in
                print("An error occured")
                print(completion)
            } receiveValue: { [weak self] model in
                self?.userDetail = model
//                print("The detail result from the network call is: \(model)")
            }
            .store(in: &subscriptions)

    }
    
    func paginating() {
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
//                for imageKey in self.userStoredData {
//                    if let userData = self.manager.getCahce(key: imageKey) {
//                        print("Getting saved image! \(userData)")
//                        let userData = UserModel(id: Double(userData.id) ?? 0, username: userData.username, avatar: nil, userType: userData.userType, userInfo: String(userData.id) + "detail")
//                        self.userDetail.append(userData)
//                    }
//                }
            }
        }
    }
}
