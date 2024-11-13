//
//  CellCompleteTaskTableViewCell.swift
//  todoapp
//
//  Created by admin on 7/11/24.
//

import UIKit

class CellCompleteTaskTableViewCell: UITableViewCell {
    @IBOutlet weak var mTaskTitleLabel: UILabel!
    @IBOutlet weak var mCategoryImage: UIImageView!
    @IBOutlet weak var mTimeLabel: UILabel!
    @IBOutlet weak var mCheckBoxImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func onBind(_ data: TaskData) {
        mTaskTitleLabel.alpha = 0.5
        mCategoryImage.alpha = 0.5
        mTimeLabel.alpha = 0.5
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: UIColor.black,
            .foregroundColor: UIColor.gray
        ]
        let strikethroughText = NSAttributedString(string: data.taskTitle, attributes: attributes)
        mTaskTitleLabel.attributedText = strikethroughText
        mTimeLabel.text=DateUtils.formatTimeTo12Hour( data.time)
        mTaskTitleLabel.text = data.taskTitle
        mCategoryImage.image = UIImage(named:"\( ImageUtils.convertCategoryTypeToImage(data.category))")
        mCheckBoxImage.image =  UIImage(named: "check")
    }
    
}
