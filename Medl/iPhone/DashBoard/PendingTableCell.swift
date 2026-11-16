//
//  PendingTableCell.swift
//  Medl
//
//  Created by mac-15 on 23/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class PendingTableCell: UITableViewCell {

    @IBOutlet weak var titleNameLbl: UILabel!
    @IBOutlet weak var issuedByLbl: UILabel!
    @IBOutlet weak var btn_DisplayList: UIButton!
    @IBOutlet weak var select_btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
