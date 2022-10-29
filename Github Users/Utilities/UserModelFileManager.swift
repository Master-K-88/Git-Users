//
//  UserModelFileManager.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import Foundation
import UIKit

class UserModelFileManager: GetPathProtocol {
    static let instance = UserModelFileManager()
    var folderName = "users_data"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
//                print("Created folder")
            } catch let error {
//                print("Error creating folder. \(error)")
            }
        }
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else { return nil }
        return folder.appendingPathComponent(key + "")
    }
    
    func add(key: String, value: UserCellModel) {
        guard
              let url = getImagePath(key: key) else {
            return
        }
        
        do {
//            let writeData = try JSONSerialization.data(withJSONObject: value, options: []) // data.write(to: url)
            let writeData = try JSONEncoder().encode(value)
            try writeData.write(to: url, options: [])
        } catch let error {
//            print("Error saving to file manager. \(error)")
        }
    }
    
    func getCahce(key: String) -> UserCellModel? {
        guard let fileName = getImagePath(key: key),
              FileManager.default.fileExists(atPath: fileName.path) else { return nil }
//        print("The filepath is \(fileName)")
        do {
            if FileManager.default.fileExists(atPath: fileName.path){
                let dataJSON = try Data(contentsOf: fileName, options: [])
                let userData = try JSONDecoder().decode(UserCellModel.self, from: dataJSON)
//                print("The user data is : \(userData)")
                return userData
            }
        } catch (let error) {
//            print("An error: \(error) to get data")
        }
        return nil
    }
    
}
