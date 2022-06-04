//
//  DataManager.swift
//  Test Balink
//
//  Created by Максим Казаков on 03.06.2022.
//

import Foundation

protocol DataManager: AnyObject {
    func save(model: [User])
    func fetch() -> [User]
}
