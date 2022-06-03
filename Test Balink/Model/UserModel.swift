//
//  User.swift
//  Test Balink
//
//  Created by Давид Михайлов on 02.06.2022.
//

import Foundation

struct User: Codable {
    let avatar: String
    let email: String
    let id: Int
    let first_name: String
    let last_name: String
}

struct Initial: Codable {
    let page: Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [User]
    let support: Support
}

struct Support: Codable {
    let url: String
    let text: String
}
