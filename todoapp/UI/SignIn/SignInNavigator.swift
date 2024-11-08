//
//  SignInNavigator.swift
//  todoapp
//
//  Created by admin on 6/11/24.
//
import UIKit

class SignInNavigator : Navigator{
    
    func signUp(){
        let viewController = SignUpViewController(nibName: SignUpViewController.className, bundle: nil)
        let navigator = SignUpNavigator(with: viewController)
        let viewModel = SignUpViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
    func pushHome(){
        let viewController = HomeViewController(nibName: HomeViewController.className, bundle: nil)
        let navigator = HomeNavigator(with: viewController)
        let viewModel = HomeViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] () in
            guard let self = self else { return }
            if let count = self.navigationController?.viewControllers.count, count >= 2 {
                self.navigationController?.viewControllers.removeSubrange(0..<count - 1 )
            }
        }
        navigationController?.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
