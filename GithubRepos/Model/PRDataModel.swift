//
//  PRDataModel.swift
//  GithubRepos
//
//  Created by Veeresh Kumbar on 18/01/23.
//

import Foundation

public struct PRDataModel: Codable {
    let title: String
    let createdAt: String
    let closedAt: String
    
    let user: UserData?
    
    enum CodingKeys: String, CodingKey {
        case title
        case createdAt = "created_at"
        case closedAt = "closed_at"
        case user
    }
}

public struct UserData: Codable {
    let userName: String
    let profileImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "login"
        case profileImageUrl = "avatar_url"
    }
}
