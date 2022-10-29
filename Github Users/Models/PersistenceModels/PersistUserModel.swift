//
//  PersistUserModel.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import Foundation
import RealmSwift

protocol UserDetailDataProtocol {
    var id: Double {get set}
    var username: String {get set}
    var avatar: String {get set}
    var userType: String {get set}
    var userInfo: String {get set}
    var location: String {get set}
    var fullName: String {get set}
    var company: String {get set}
    var bio: String {get set}
    var email: String {get set}
    var twitter: String {get set}
    var favourite: Bool {get set}
    
}

class PersistUserModel: Object, UserDetailDataProtocol {
    
    @objc dynamic var id: Double = 0
    @objc dynamic var username: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var userType: String = ""
    @objc dynamic var userInfo: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var fullName: String = ""
    @objc dynamic var company: String = ""
    @objc dynamic var bio: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var twitter: String = ""
    @objc dynamic var favourite: Bool = false
    
}
