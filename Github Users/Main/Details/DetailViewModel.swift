//
//  DetailViewModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import Foundation
import Combine

class DetailViewModel: ConvertToPesistenceModel {
    var manager: UserModelFileManager = UserModelFileManager.instance
    
    var detailEndpoint: String
    @Published var userDetail: UserDetailDataProtocol //= DetailModel(id: 0)
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    let userDetailService: GithubUserDetailAPIProtocol = UserDetailService()
    
    private let userStorage: PersistenceService = FavGithubUser()
    
    init(endPoint: String?, user: UserDetailDataProtocol) {
        userDetail = user
        guard let endpointWithCom1 = endPoint?.split(separator: "."), endpointWithCom1.count > 2 else {
            detailEndpoint = ""
            return
        }
        let endpointWithCom = endpointWithCom1[2]
        let newEndpoint = endpointWithCom.suffix(endpointWithCom.count - 3)
        detailEndpoint = String(newEndpoint)
    }
    
    func addFavUser() {
        userDetail.favourite = true
        let user = convertToPersistenceModel()
        userStorage.addFavUser(user: user)
        
    }
    
    func removeuser() {
        userStorage.removeFavUser(user: userDetail)
    }
    
    
    func fetchData() {
        if !detailEndpoint.isEmpty {
            userDetailService.fetchData(endpoint: detailEndpoint)
                .receive(on: RunLoop.main)
                .sink { completion in
                } receiveValue: { [weak self] model in
                    self?.userDetail = model
                }
                .store(in: &subscriptions)
        }
        userDetail = DetailModel(id: 0)
    }
    
    func getSavedData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else {
                return
            }
            if self.userDetail.fullName.isEmpty {
                self.fetchData()
            }
            
        }
    }
}
