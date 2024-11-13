//
//  SignInViewModel.swift
//  todoapp
//
//  Created by admin on 6/11/24.
//
import RxSwift
import UIKit
class SignInViewModel : ViewModel{
    private let navigator : SignInNavigator
    private var username : String=""
    private var password : String=""
    
    var showError : ((String)->Void)?
    var onLoginSuccess : (()->Void)?
    
    init(navigator: SignInNavigator){
        self.navigator = navigator
        super.init(navigator: navigator)
    }
    
    func signUp(){
        self.navigator.signUp()
    }
    var validateForm : Bool {
        if username.isEmpty{
            showError?("errorUsername".translated())
            return false
        }
        if password.isEmpty{
            showError?("errorPassword".translated())
            return false
        }
        return true
    }
    func signIn(){
        if validateForm {
            let usr = UserModel( username: "\(self.username)@gmail.com", password: password);
            SupabaseClientManager.Instance.userService
                .getUser(u: usr)
                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: {u in
                    self.onLoginSuccess?()
                },onFailure: {e in
                    self.showError?("\(e.localizedDescription)")
                    
                }).disposed(by: disposeBag)
        }
    }
    
    func setUsername(_ username: String){
        self.username = username
    }
    
    func setPassword(_ password: String){
        self.password = password
    }
    
    
}
