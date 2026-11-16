//
//  PaymentTableCell.swift
//  Medl
//
//  Created by mac-15 on 24/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class PaymentTableCell: UITableViewCell {

    
    @IBOutlet weak var prscName: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var btn_check: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
