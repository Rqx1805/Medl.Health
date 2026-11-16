//
//  PaymentCheckoutCell.swift
//  Medl
//
//  Created by Ashish Soni on 28/08/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class PaymentCheckoutCell: UITableViewCell {

    @IBOutlet weak var RxImg: UIImageView!
    @IBOutlet weak var medNameLbl: UILabel!
    @IBOutlet weak var quantyLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
