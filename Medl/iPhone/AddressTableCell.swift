//
//  AddressTableCell.swift
//  Medl
//
//  Created by mac-15 on 08/01/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class AddressTableCell: UITableViewCell {

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
