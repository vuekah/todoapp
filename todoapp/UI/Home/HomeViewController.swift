//
//  HomeViewController.swift
//  todoapp
//
//  Created by admin on 5/11/24.
//



import UIKit
import RxSwift
import RxCocoa

class HomeViewController: ViewController<HomeViewModel, HomeNavigator>,CellTaskDelegate {
    @IBOutlet weak var mChangeLanguageButton: UIButton!
    @IBOutlet weak var toDoListLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var mDateLabel: UILabel!
    @IBOutlet weak var mToDoTableView: UITableView!
    @IBOutlet weak var mCompletedTableView: UITableView!
    @IBOutlet weak var mAddNewTaskButton: UIButton!
    @IBOutlet weak var mSignOutButton: UIButton!
    @IBAction func mAddNewTaskButtonTouchDown(_ sender: Any) {
        self.viewModel.pushToAddTask()
    }
    private var toDoList: [TaskData] = []
    private var completedList: [TaskData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.tasksObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] tasks in
                guard let self = self else { return }
                
                self.toDoList = tasks.filter { !$0.isCompleted }
                self.completedList = tasks.filter { $0.isCompleted }
                
                self.mToDoTableView.reloadData()
                self.mCompletedTableView.reloadData()
                
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func mSignOutButtonTouchDown(_ sender: Any) {
        viewModel.signOut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.viewModel.fetchItem()
        super.viewWillAppear(animated)
    }
    
    func didTapTickButton(forTask task: TaskData) {
        if let index = toDoList.firstIndex(where: { $0.id == task.id }) {
            toDoList.remove(at: index)
            completedList.append(task)
            
        }
        mToDoTableView.reloadData()
        mCompletedTableView.reloadData()
        
    }
    
    @IBAction func mChangeLanguageButtonTouchDown(_ sender: Any) {
        if LocalizeDefaultLanguage == "en" {
            LocalizeDefaultLanguage = "vi"
        } else {
            LocalizeDefaultLanguage = "en"
        }
        
        UserDefaults.standard.set(LocalizeDefaultLanguage, forKey: LocalizeUserDefaultKey)
        
        
        applyLocalization()
        self.viewDidLoad()
    }
    
    func applyLocalization() {
        toDoListLabel.text = "myToDoList".translated()
        completedLabel.text = "completed".translated()
        mAddNewTaskButton.setTitle("addNewTask".translated(), for: .normal)
        mDateLabel.text = getCurrentDate()
    }
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        formatter.locale = Locale(identifier: LocalizeDefaultLanguage)
        
        return formatter.string(from: Date())
    }
    
    
    override func setupUI() {
        
        
        mAddNewTaskButton.layer.cornerRadius = 25
        mAddNewTaskButton.layer.masksToBounds = true
        mCompletedTableView.layer.cornerRadius = 10
        mCompletedTableView.layer.masksToBounds = true
        mToDoTableView.layer.cornerRadius = 10
        mToDoTableView.layer.masksToBounds = true
        
        // Register cell for both tables
        mToDoTableView.register(UINib(nibName: "CellTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        mCompletedTableView.register(UINib(nibName: "CellCompleteTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "cellcomplete")
        ///////
        self.navigationController?.navigationBar.isHidden = true
        mToDoTableView.dataSource = self
        mToDoTableView.delegate = self
        mCompletedTableView.dataSource = self
        mCompletedTableView.delegate = self
        
        //set language
        applyLocalization()
        
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mToDoTableView {
            return self.toDoList.count
        } else {
            return self.completedList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mToDoTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTaskTableViewCell
            cell.onBind(self.toDoList[indexPath.row])
            cell.delegate = self
            return cell
        } else {
            let cellComplete = tableView.dequeueReusableCell(withIdentifier: "cellcomplete", for: indexPath) as! CellCompleteTaskTableViewCell
            cellComplete.onBind(self.completedList[indexPath.row])
            return cellComplete
        }
    }
    
}


