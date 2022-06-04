//
//  User.swift
//  Test Balink
//
//  Created by Давид Михайлов on 01.06.2022.
//

import Foundation

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
        case email
    }

    let id: Int
    let firstName: String
    let lastName: String
    let avatar: URL?
    let email: String
}

struct Initial: Codable {
    let data: [User]
}


