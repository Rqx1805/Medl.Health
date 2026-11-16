//
//  InProgressTableCell.swift
//  Medl
//
//  Created by mac-15 on 05/12/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class InProgressTableCell: UITableViewCell {

    @IBOutlet weak var titleNameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var issuedByLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var routeLbl: UILabel!
    @IBOutlet weak var frequencylbl: UILabel!
    @IBOutlet weak var durationlbl: UILabel!
    @IBOutlet weak var refillLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
