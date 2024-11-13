//
//  AddTaskViewController.swift
//  todoapp
//
//  Created by admin on 5/11/24.
//

import UIKit


class AddTaskViewController: ViewController<AddTaskViewModel,AddTaskNavigator> {
    
    @IBOutlet weak var mNoteLabel: UILabel!
    @IBOutlet weak var mTimeLabel: UILabel!
    @IBOutlet weak var mDateLabel: UILabel!
    @IBOutlet weak var mCategoryLabel: UILabel!
    @IBOutlet weak var mTaskTitleLabel: UILabel!
    @IBOutlet weak var mBookImage: UIButton!
    @IBOutlet weak var mDateImage: UIButton!
    @IBOutlet weak var mCupImage: UIButton!
    @IBOutlet weak var mDatePickerView: UIStackView!
    @IBOutlet weak var mTimePickerView: UIStackView!
    @IBOutlet weak var mNoteTextField: UITextField!
    @IBOutlet weak var mDateTextField: UITextField!
    @IBOutlet weak var mTimeTextField: UITextField!
    @IBOutlet weak var mTaskTitleTextField: UITextField!
    @IBOutlet weak var mAddNewTaskButton: UIButton!
    @IBOutlet weak var mDatePickerButton: UIButton!
    @IBOutlet weak var mTimePickerButton: UIButton!
    
    let datePickerAlertController = UIAlertController(title: "Select date", message: nil, preferredStyle: .actionSheet)
    let timePickerAlertController = UIAlertController(title: "Select time", message: nil, preferredStyle: .actionSheet)
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    private var cateSelected = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        viewModel.showErrorMessage = { [weak self] errorMessage in
            self?.showErrorMessage(errorMessage)
        }
        viewModel.showSuccessMessage = { [weak self] successMessage in
            self?.showSuccessMessage(successMessage)
        }
        
        viewModel.updateButtonAlpha = { [weak self]  selectedButton in
            self?.toggleButtonAlphas(except: selectedButton)
        }
        
        mAddNewTaskButton.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        
        setUpDateTimePicker()
        setUpAlertController()
        mDatePickerButton.addTarget(self, action: #selector(showDatePicker), for: .touchDown)
        mTimePickerButton.addTarget(self, action: #selector(showTimePicker), for: .touchDown)
        
        toggleButtonAlphas(except: mBookImage)
        
    }
    
    @objc func saveTask(){
        viewModel.setTaskTitle(mTaskTitleTextField.text ?? "")
        viewModel.setTaskCategory(cateSelected)
        viewModel.setDate(datePicker.date)
        viewModel.setTime(timePicker.date)
        viewModel.setNotes(mNoteTextField.text ?? "")
        viewModel.saveTask()
    }
    
    @IBAction func mBookImageTouchDown(_ sender: UIButton) {
        cateSelected = CategoryType.one.rawValue
        viewModel.toggleButtonAlphas(except: sender)
    }
    
    @IBAction func mDateImageTouchDown(_ sender: UIButton) {
        cateSelected = CategoryType.two.rawValue
        viewModel.toggleButtonAlphas(except: sender)
    }
    
    @IBAction func mCupImageTouchDown(_ sender: UIButton) {
        cateSelected = CategoryType.three.rawValue
        viewModel.toggleButtonAlphas(except: sender)
    }
    
    private func toggleButtonAlphas( except selectedButton: UIButton) {
        let buttons: [UIButton] = [mBookImage, mDateImage, mCupImage]
        
        for button in buttons {
            button.alpha = button == selectedButton ? 1.0 : 0.2
        }
    }
    
    private func setUpDateTimePicker () {
        
        datePicker.datePickerMode = .date
        timePicker.datePickerMode = .time
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
            timePicker.preferredDatePickerStyle = .wheels
        }
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setupUI() {
        setTitle("addNewTask".translated(), subTitle: nil)
        showLeftButton(image:UIImage(named: "close")?.withRenderingMode(.alwaysOriginal))
        mDatePickerView.layer.cornerRadius=8
        mDatePickerView.layer.masksToBounds=true
        mTimePickerView.layer.cornerRadius=8
        mTimePickerView.layer.masksToBounds=true
        mAddNewTaskButton.layer.cornerRadius = 25
        mAddNewTaskButton.layer.masksToBounds = true
        //padding
        mDateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: mDateTextField.frame.height))
        mDateTextField.leftViewMode = .always
        mTimeTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: mTimeTextField.frame.height))
        mTimeTextField.leftViewMode = .always
        
        mDateTextField.text = viewModel.date
        mTimeTextField.text = viewModel.time
        mNoteTextField.delegate = self
        mTaskTitleTextField.delegate = self
        
        //language
        mTaskTitleLabel.text = "taskTitle".translated()
        mTaskTitleTextField.placeholder = "taskTitle".translated()
        mNoteTextField.placeholder = "notes".translated()
        mCategoryLabel.text =   "category".translated()
        mDateLabel.text = "date".translated()
        mTimeLabel.text = "time".translated()
        mNoteLabel.text = "notes".translated()
        mAddNewTaskButton.setTitle("save".translated(), for: .normal)
        
        
    }
    
    private func setUpAlertController () {
        timePickerAlertController.view.addSubview(timePicker)
        timePicker.isHidden = false
        
        datePickerAlertController.view.addSubview(datePicker)
        datePicker.isHidden = false
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: datePickerAlertController.view.centerXAnchor),
            datePickerAlertController.view.heightAnchor.constraint(equalToConstant: 500),
            datePicker.bottomAnchor.constraint(equalTo: datePickerAlertController.view.centerYAnchor, constant: 120),
            
            timePicker.centerXAnchor.constraint(equalTo: timePickerAlertController.view.centerXAnchor),
            timePickerAlertController.view.heightAnchor.constraint(equalToConstant: 400),
            timePicker.bottomAnchor.constraint(equalTo: timePickerAlertController.view.centerYAnchor, constant: 70)
        ])
        
        let dateConfirmAction = UIAlertAction(title: "Confirm", style: .default){ _ in
            self.dateChanged()
        }
        let dateCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        datePickerAlertController.addAction(dateConfirmAction)
        datePickerAlertController.addAction(dateCancelAction)
        
        let timeConfirmAction = UIAlertAction(title: "Confirm", style: .default){ _ in
            self.timeChanged()
        }
        let timeCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        timePickerAlertController.addAction(timeConfirmAction)
        timePickerAlertController.addAction(timeCancelAction)
    }
    
    @objc func showDatePicker() {
        present(datePickerAlertController, animated: true, completion: nil)
    }
    
    @objc func showTimePicker() {
        present(timePickerAlertController, animated: true, completion: nil)
    }
    
    @objc func timeChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        mTimeTextField.text = formatter.string(from: timePicker.date)
    }
    
    @objc func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        mDateTextField.text = formatter.string(from: datePicker.date)
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSuccessMessage(_ message: String) {
        let alert = UIAlertController(title: "Successfully", message: message, preferredStyle: .alert)
        mTaskTitleTextField.text=""
        mNoteTextField.text=""
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
