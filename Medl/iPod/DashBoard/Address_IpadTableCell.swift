//
//  Address_IpadTableCell.swift
//  Medl
//
//  Created by Ashish Soni on 17/07/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class Address_IpadTableCell: UITableViewCell {

      @IBOutlet weak var AddressLbl: UILabel!
      @IBOutlet weak var phoneNumberLbl: UILabel!
      @IBOutlet weak var pickUpTimeLbl: UILabel!
      @IBOutlet weak var checkBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
