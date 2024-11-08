//
//  BaseRouter.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/4/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxSwift

class Navigator {
    let disposeBag = DisposeBag()
    
    weak var viewController: UIViewController?
    
    lazy var navigationController: UINavigationController? = {
        return self.viewController?.navigationController
    }()
    
   
    
    init(with viewController: UIViewController) {
        self.viewController = viewController
    }
   
}
