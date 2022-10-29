//
//  RealmPersistenceService.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import Foundation
import RealmSwift

protocol PersistenceService {
//    associatedtype T
    func addFavUser(user: PersistUserModel)
    func removeFavUser(user: UserDetailDataProtocol)
    func removeAllFavUser()
    var allFavUser: Results<PersistUserModel> { get }
}

protocol ConvertToPesistenceModel {
    var userDetail: UserDetailDataProtocol { get set }
    func convertToPersistenceModel() -> PersistUserModel 
}

extension ConvertToPesistenceModel {
    
    func convertToPersistenceModel() -> PersistUserModel {
        let gitUser = PersistUserModel()
        gitUser.id = userDetail.id
        gitUser.avatar = "" //userDetail.avatar ?? Data()
        gitUser.username = userDetail.username ?? ""
        gitUser.userType =  userDetail.userType ?? ""
        gitUser.userInfo = userDetail.userInfo ?? ""
        gitUser.location = userDetail.location ?? ""
        gitUser.fullName = userDetail.fullName ?? ""
        gitUser.company = userDetail.company ?? ""
        gitUser.bio = userDetail.bio ?? ""
        gitUser.email = userDetail.email ?? ""
        gitUser.twitter = userDetail.twitter ?? ""
        gitUser.favourite = userDetail.favourite
        
        return gitUser
    }
}

class FavGithubUser: PersistenceService {
    private let realm: Realm!
    
    
    
    init() {
        realm = try! Realm()
    }
    
    var allFavUser: Results<PersistUserModel> {
        return realm.objects(PersistUserModel.self)
    }
    
    func addFavUser(user: PersistUserModel) {
//        let gitUser = PersistUserModel()
//        gitUser.fullName = user.fullName ?? ""
//        gitUser.avatar = user.avatar ?? ""
//        gitUser.favourite = user.favourite
//        print("The saved user has: \(gitUser)")
        do {
            try realm.write {
                let favUser = realm.objects(PersistUserModel.self).where { newUser in
                    newUser.id == user.id
                }
                if favUser.isEmpty {
                    self.realm.add(user)
                }
                
            }
        } catch let error {
            print("An error of \(error) occured")
        }
        
    }
    
    func removeFavUser(user: UserDetailDataProtocol) {
        let favUser = realm.objects(PersistUserModel.self).where { newUser in
            newUser.id == user.id
        }
        do {
            try realm.write {
                self.realm.delete(favUser)
            }
        } catch (let error) {
            print("An error of \(error) occured")
        }
    }
    
    func removeAllFavUser() {
        do {
            try realm.write {
                self.realm.delete(allFavUser)
            }
        } catch (let error) {
            print("An error of \(error) occured")
        }
    }
    
}
