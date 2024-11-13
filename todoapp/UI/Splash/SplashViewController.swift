//
//  SplashViewController.swift
//  todoapp
//
//  Created by admin on 5/11/24.
//

import UIKit

class SplashViewController: ViewController<SplashViewModel,SplashNavigator> {

    override func viewDidLoad() {
        let navigator = SplashNavigator(with: self)
        viewModel = SplashViewModel(navigator: navigator)
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=true
        view.backgroundColor = .brown
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
