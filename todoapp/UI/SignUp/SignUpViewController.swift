//
//  SignUpViewController.swift
//  todoapp
//
//  Created by admin on 6/11/24.
//

import UIKit

class SignUpViewController: ViewController<SignUpViewModel, SignUpNavigator> {
    
    @IBOutlet weak var mUsernameTextField: UITextField!
    @IBOutlet weak var mPasswordTextField: UITextField!
    @IBOutlet weak var mSignUpButton: UIButton!
    @IBOutlet weak var mRePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.showMessage = { [weak self] errorMessage in
            self?.showMessage(errorMessage)
        }
        self.navigationController?.navigationBar.isHidden=false

        
       

        
    }
    @IBAction func mSignUpButtonTouchDown(_ sender: Any) {
        viewModel.setUsername(mUsernameTextField.text ?? "") 
        viewModel.setPassword(mPasswordTextField.text ?? "")
        viewModel.setRePassword(mRePasswordTextField.text ?? "")
        viewModel.signUp()
    }
    
    func showMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "alert".translated(), message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".translated(), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
   
}
