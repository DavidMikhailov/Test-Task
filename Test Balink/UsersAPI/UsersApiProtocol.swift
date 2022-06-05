//
//  UsersApiProtocol.swift
//  Test Balink
//
//  Created by Давид Михайлов on 05.06.2022.
//

import Foundation

protocol UsersApiProtocol: AnyObject {
    func get(onComplete: @escaping ([User]?) -> Void)
}
