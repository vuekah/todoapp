//
//  AddtaskViewModel.swift
//  todoapp
//
//  Created by admin on 5/11/24.
//
import UIKit
import RxSwift

class AddTaskViewModel : ViewModel{
    
    public var date : String?
    public var time : String?
    private var categoryType : Int = 1;
    private var taskTitle : String = ""
    private var notes : String=""
    private var buttons : [UIButton] = []
    private let formatter = DateFormatter()
    var showErrorMessage: ((String) -> Void)?
    var showSuccessMessage: ((String) -> Void)?
    var updateButtonAlpha: ((UIButton) -> Void)?
    private let navigator : AddTaskNavigator
    
    init(navigator: AddTaskNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
        date = getDate()
        time = getTime()
        
    }
    
    func toggleButtonAlphas(except selectedButton: UIButton) {
        updateButtonAlpha?( selectedButton)
    }
    
    // MARK: - Validation Logic
    func validateForm() -> Bool {
        // Check if all required fields are filled
        if taskTitle.isEmpty {
            showErrorMessage?("Task title is required.")
            return false
        }
        if notes.isEmpty {
            showErrorMessage?("Notes are required.")
            return false
        }
        return true
    }
    
    // MARK: - Save Task
    func saveTask() {
        if validateForm() {
            
            guard let validDate = date else {
                print("Date is nil!")
                return
            }
            
            
            guard let dateFormat = DateUtils.convertDateString(input: validDate) else {
                print("Failed to convert date format!")
                return
            }
            
            
            let task = TaskInsertData(uid:SupabaseClientManager.Instance.supabaseClient.auth.currentUser?.id, category: categoryType,
                                      taskTitle: taskTitle,
                                      date: dateFormat,
                                      time: time!,
                                      notes: notes,
                                      isCompleted: false
                                      
            )
            
            SupabaseClientManager.Instance.todoService.addItem(task: task).observe(on: MainScheduler.instance)
                .subscribe(onSuccess: {
                    task in
                    self.showSuccessMessage?("Added task successfully.")
                    print("Added task: \(task)")
                },onFailure: {error in self.showErrorMessage?("Failed to add task: \(error)")})
                .disposed(by: disposeBag)
        }
    }
    
    // MARK: - Setters for fields (called by ViewController)
    func setTaskTitle(_ taskTitle: String) {
        self.taskTitle = taskTitle
    }
    
    func setTaskCategory(_ categoryType:Int){
        self.categoryType = categoryType
    }
    
    func setDate(_ date:Date){
        formatter.dateFormat = "MMMM dd, yyyy"
        self.date = formatter.string(from: date)
    }
    
    func setTime(_ time:Date){
        formatter.dateFormat = "HH:mm"
        
        self.time = formatter.string(from: time)
    }
    
    func setNotes(_ notes:String){
        self.notes = notes
    }
    
    // MARK: - Get Date, Time now
    func getDate()->String{
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
    
    func getTime()->String{
        formatter.dateFormat = "HH:mm a"
        return formatter.string(from: Date())
    }
}
