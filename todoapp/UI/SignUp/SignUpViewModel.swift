//
//  SignUpNavigator.swift
//  todoapp
//
//  Created by admin on 6/11/24.
//

import UIKit
import RxSwift
class SignUpViewModel : ViewModel{
    private let navigator : SignUpNavigator
    private(set) var username : String  = ""
    private var password : String  = ""
    private var rePassword : String = ""
    
    var showMessage : ((String)->Void)?
    
    
    
    init(navigator: SignUpNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
      
    }
    
    func validateForm()->Bool{
        if username.isEmpty {
            showMessage?("errorUsername".translated())
            return false
        }
        if password.isEmpty {
            showMessage?("errorPassword".translated())
            return false
        }
        if rePassword.isEmpty {
            showMessage?("errorRePassword".translated())
            return false
        }else{
            if password != rePassword {
                showMessage?("notMatch".translated())
                return false
            }
        }
        return true
    }
    
    func signUp(){
        if validateForm(){
            let usr = UserModel( username: "\(self.username)@gmail.com", password: password)
            SupabaseClientManager.Instance.userService.addUser(u: usr)
                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: {u in
                    self.showMessage?("regSuccessfully".translated())
                },onFailure: {e in
                    self.showMessage?("\(e.localizedDescription)")
                    
                }).disposed(by: disposeBag)
            
            
        }
    }
    
   
    
    func setUsername(_ username: String){
        self.username = username
    }
    
    func setPassword(_ password: String){
        self.password = password
    }
    func setRePassword(_ rePassword: String){
        self.rePassword = rePassword
    }
}
