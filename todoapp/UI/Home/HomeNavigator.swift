//
//  File.swift
//  todoapp
//
//  Created by admin on 5/11/24.
//

import UIKit

class HomeNavigator: Navigator {
    func presentSideMenu() {
        
    }
    
    func pushSignIn(){
        let viewController = SignInViewController(nibName: SignInViewController.className, bundle: nil)
        let navigator = SignInNavigator(with: viewController)
        let viewModel = SignInViewModel(navigator: navigator)
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
    
    func pushToAddNewtask(){
        let viewController = AddTaskViewController(nibName: AddTaskViewController.className, bundle: nil)
        let navigator = AddTaskNavigator(with: viewController)
        let viewModel = AddTaskViewModel(navigator: navigator)
        viewController.viewModel = viewModel

        navigationController?.pushViewController(viewController, animated: true)

    }
}
