//
//  SplashViewModel.swift
//  todoapp
//
//  Created by admin on 5/11/24.
//

import Foundation

class SplashViewModel:ViewModel {
    private let test : Bool = false
    private let navigator : SplashNavigator
    
    init(navigator: SplashNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
        if ((SupabaseClientManager.Instance.supabaseClient.auth.currentSession?.isExpired) != nil){
            print("ahjahahahahaha")
            navigator.pushHome()
        }else{
            navigator.pushSignIn()
        }
        
    }
}
