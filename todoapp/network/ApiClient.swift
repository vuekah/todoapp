//
//  Constants.swift
//  todoapp
//
//  Created by admin on 4/11/24.

import Foundation
import Supabase
import RxSwift
import RxCocoa

class SupabaseClientManager {
    static let Instance = SupabaseClientManager()
    private var tdoService : TodoService
    private var uService : UserService
    private(set) var supabaseClient: SupabaseClient
    
    private init() {
        supabaseClient = SupabaseClient(
            supabaseURL: URL(string: Config.Network.apiBaseUrl)!,
            supabaseKey: Config.Network.apiKey
        )
        
        tdoService = TodoService(supabaseClient: supabaseClient)
        uService = UserService(supabaseClient: supabaseClient)
    }
    var todoService: TodoService {
            return tdoService
        }
    var userService: UserService {
        return uService
    }
}
