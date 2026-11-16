//
//  NotificationTableCell.swift
//  Medl
//
//  Created by mac-15 on 26/11/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class NotificationTableCell: UITableViewCell {
    
    
    @IBOutlet weak var notificationMsgLbl: UILabel!
    
    @IBOutlet weak var notificationTimeLbl: UILabel!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.layer.cornerRadius = 5
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowView.layer.shadowColor = UIColor.systemGray.cgColor
        shadowView.layer.shadowRadius = 4
        shadowView.layer.shadowOpacity = 0.5
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
