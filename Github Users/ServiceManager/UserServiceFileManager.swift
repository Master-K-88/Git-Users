//
//  UserServiceFileManager.swift
//  Github Users
//
//  Created by Oko-osi Korede on 28/10/2022.
//

import Foundation
import Combine

protocol GetPathProtocol {
    var folderName: String { get set }
    func getFolderPath() -> URL?
}

extension GetPathProtocol {
    func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
}

class UserServiceFileManager: GetPathProtocol {
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!

    static let instance = UserServiceFileManager()
    var folderName: String = "users_data"
    var newPath: URL?
    @Published var storedData: [String] = []
    
    private init() {
        newPath = getFolderPath()
        
        storedData = listFilesFromDocumentsFolder() ?? []
    }
    
    func listFilesFromDocumentsFolder() -> [String]?
    {
        let fileMngr = FileManager.default;

        // Full path to documents directory
        let docs = getFolderPath()

        // List all contents of directory and return as [String] OR nil if failed
        return try? fileMngr.contentsOfDirectory(atPath: docs?.path ?? "")
    }

}

