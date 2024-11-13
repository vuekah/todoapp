//
//  CellTaskTableViewCell.swift
//  todoapp
//
//  Created by admin on 4/11/24.
//
import UIKit
import RxSwift
import RxCocoa

protocol CellTaskDelegate: AnyObject {
    func didTapTickButton(forTask task: TaskData)
}


class CellTaskTableViewCell: UITableViewCell {
    let disposeBag = DisposeBag()
    @IBOutlet weak var mTaskTitleLabel: UILabel!
    @IBOutlet weak var mCategoryImage: UIImageView!
    @IBOutlet weak var mTimeLabel: UILabel!
    @IBOutlet weak var mCheckBoxImage: UIImageView!
    @IBOutlet weak var mViewItem: UIView!
    private var task:TaskData?
    weak var delegate: CellTaskDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))
        mViewItem.isUserInteractionEnabled = true
        mViewItem.addGestureRecognizer(tapGesture)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    @objc func didTapCheckBox() {
        guard let data = task else { return }
        
        delegate?.didTapTickButton(forTask: data)
        SupabaseClientManager.Instance.todoService.updateItem(id: data.id!).observe(on: MainScheduler.instance)
            .subscribe(onSuccess:{ task in
                self.delegate?.didTapTickButton(forTask: data)
                
            }, onFailure: {
                error in print ("error")
            }).disposed(by: disposeBag)
        
    }
    
    
    func onBind(_ data: TaskData) {
        self.task = data
        mTimeLabel.text = DateUtils.formatTimeTo12Hour(data.time)
        mTaskTitleLabel.text = data.taskTitle
        mCategoryImage.image = UIImage(named:"\( ImageUtils.convertCategoryTypeToImage(data.category))")
        mCheckBoxImage.image =  UIImage(named: "uncheck")
        
    }
    
    
}
