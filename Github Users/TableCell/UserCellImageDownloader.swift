//
//  UserCellViewModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import Foundation
import Combine
import UIKit

protocol GetSavedDataProtocol {
    var manager: UserModelFileManager { get set }
    func getSavedData()
}

class UserCellImageDownloader: GetSavedDataProtocol {
    
    var userData: UserModel?
    @Published var image: UIImage? = nil
    @Published var userName: String = ""
    @Published var userType: String = ""
    @Published var isLoading: Bool = false
    let urlString: String
    let imageKey: String
    var cancellables = Set<AnyCancellable>()
    var manager: UserModelFileManager = UserModelFileManager.instance
    
    init(model: UserModel) {
        userData = model
        urlString = model.avatar ?? ""
        imageKey = String(model.id)
        getSavedData()
    }
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> Data? in
                return data
            }
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self,
                      let data = returnedImage else { return }
                self.image = UIImage(data: data)
                let storedUserData = UserCellModel(id: String(self.userData?.id ?? 0), username: self.userData?.username ?? "", avatarUrl: data, userType: self.userData?.userType ?? "")
                self.manager.add(key: self.imageKey, value: storedUserData)
            }
            .store(in: &cancellables)

    }
    
    func getSavedData() {
        if let userData = manager.getCahce(key: imageKey) {
            image = UIImage(data: userData.avatarUrl)
            userName = userData.username
            userType = userData.userType
            print("Getting saved image! \(userData)")
        } else {
            downloadImage()
            print("Downloading Images now!")
        }
        
    }
    
}


struct UserCellModel: Identifiable, Codable {
    let id: String
    let username: String
    let avatarUrl: Data
    let userType: String
    
}
