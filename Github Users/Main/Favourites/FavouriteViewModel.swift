//
//  FavouriteViewModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import Foundation

class FavouriteUserViewModel {
    private let userStorage: PersistenceService = FavGithubUser()
    
    var allFavGitUser: [PersistUserModel] {
        userStorage.allFavUser.map { user in
            return user
        }
    }
    
    @Published var sectionHeader: [String] = []
    @Published var allSectionedUser: [String: [PersistUserModel]] = [:]
    
    init() {
        fetchRecentData()
    }
    
    func removeAllUser() {
        userStorage.removeAllFavUser()
    }
    
    func fetchRecentData() {
        self.allSectionedUser = sortAllUsers()
    }
    
    func sortAllUsers() -> [String: [PersistUserModel]] {
        //        print("These are all users: \(allFavGitUser) and count: \(allFavGitUser.count)")
        let userArray = allFavGitUser.map { user in
            return [user.username: user]
        }
        let uniqueSection = Array(Set(allFavGitUser.map { dict in
            return dict.username.prefix(1).uppercased()
        })).sorted()
        
        sectionHeader = uniqueSection
        //        let finalSortedData = allFavGitUser.map { user in
        var dict = [String: [PersistUserModel]]()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            for section in uniqueSection {
                let sectionArray = self.allFavGitUser.map { user -> PersistUserModel? in
                    if user.username.prefix(1).uppercased() == section {
                        return user
                    }
                    return nil
                }.compactMap { $0 }
                dict[section] = sectionArray
            }
//            print("This is the section header:\(sectionHeader) and the converted array: \(dict)")
        return dict
    }
}
