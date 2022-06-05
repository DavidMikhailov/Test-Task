//
//  UsersApiProtocol.swift
//  Test Balink
//
//  Created by Давид Михайлов on 05.06.2022.
//

import Foundation

protocol UsersApiProtocol: AnyObject {
    func getUsers(onComplete: @escaping ([User]?) -> Void)
}
