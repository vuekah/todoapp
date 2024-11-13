//
//  UserModel.swift
//  todoapp
//
//  Created by admin on 6/11/24.
//

struct UserModel: Codable {
    let username: String
    let password: String
    
    var toString : String {
        return "@ - \(username) - \(password)"
    }
}
