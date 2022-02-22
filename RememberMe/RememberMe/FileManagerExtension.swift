//
//  FileManagerExtension.swift
//  RememberMe
//
//  Created by Миша Перевозчиков on 08.02.2022.
//

import Foundation

extension FileManager {
     
    static var documentDirectory: URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
            return paths[0]
    }
}
