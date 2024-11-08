//
//  HomeViewModel.swift
//  todoapp
//
//  Created by admin on 5/11/24.
//

import Foundation
import RxSwift

class HomeViewModel : ViewModel{
    private let navigator: HomeNavigator
    var todoList: [TaskData]
    private let tasksSubject = BehaviorSubject<[TaskData]>(value: [])
    
    init(navigator: HomeNavigator) {
        self.navigator = navigator
        self.todoList = []
        super.init(navigator: navigator)
    }
    
    func fetchItem() {
        SupabaseClientManager.Instance.todoService.getItems()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { tasks in
                self.todoList = tasks
                self.tasksSubject.onNext(tasks)
                print("Fetched tasks: \(tasks.count)")
            }, onFailure: { error in
                print("Error fetching tasks: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    // Observable to bind with the view controller
    var tasksObservable: Observable<[TaskData]> {
        return tasksSubject.asObservable()
    }
    
    func signOut(){
        SupabaseClientManager.Instance.userService.signOut()
        navigator.pushSignIn()
    }
    
    func pushToAddTask() {
        navigator.pushToAddNewtask()
    }
    
}
