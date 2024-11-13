//
//  SignInViewController.swift
//  todoapp
//
//  Created by admin on 6/11/24.
//

import UIKit

class SignInViewController: ViewController<SignInViewModel, SignInNavigator> {
    
    @IBOutlet weak var mUsernameTextField: UITextField!
    @IBOutlet weak var mPasswordTextField: UITextField!
    @IBOutlet weak var mSignInButton: UIButton!
    @IBOutlet weak var mSignUpButton: UIButton!
    
    override func viewDidLoad() {
        let navigator = SignInNavigator(with: self)
        viewModel = SignInViewModel(navigator: navigator)
        super.viewDidLoad()
        
        self.viewModel.showError = { [weak self] erorMessage in
            self?.showError(erorMessage)
        }
        self.viewModel.onLoginSuccess = { [weak self] in
            navigator.pushHome()
        }
    }
    
    override func setupUI() {
        applyLocalization()
    }
    func applyLocalization(){
        mUsernameTextField.placeholder = "usr".translated()
        mPasswordTextField.placeholder = "pwd".translated()
        mSignInButton.setTitle("signIn".translated(), for: .normal)
        mSignUpButton.setTitle("signUp".translated(), for: .normal)
    }
    @IBAction func mChangeLanguageButtonTouchDown(_ sender: Any) {
        if LocalizeDefaultLanguage == "en" {
            LocalizeDefaultLanguage = "vi"
        } else {
            LocalizeDefaultLanguage = "en"
        }
        
        UserDefaults.standard.set(LocalizeDefaultLanguage, forKey: LocalizeUserDefaultKey)
        applyLocalization()
    }
    
    @IBAction func mSignInButtonTouchDown(_ sender: Any) {
        self.viewModel.setUsername(mUsernameTextField.text ?? "")
        self.viewModel.setPassword(mPasswordTextField.text ?? "")
        self.viewModel.signIn()
    }
    
    @IBAction func mSignUpButtonTouchDown(_ sender: Any) {
        self.viewModel.signUp()
    }
    
    func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "alert".translated(), message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".translated(), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
