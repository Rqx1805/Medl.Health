//
//  ExpireTableCell.swift
//  Medl
//
//  Created by mac-15 on 05/12/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class ExpireTableCell: UITableViewCell {

//    @IBOutlet weak var ExpiresLbl: UILabel!
//    @IBOutlet weak var PrescriptionLbl: UILabel!
    @IBOutlet weak var DoctorNameLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
//    @IBOutlet weak var descLbl: UILabel!
//
//    @IBOutlet weak var quantityLbl: UILabel!
//    @IBOutlet weak var routeLbl: UILabel!
//    @IBOutlet weak var frequencyLbl: UILabel!
//    @IBOutlet weak var durationLbl: UILabel!
//    @IBOutlet weak var refillsLbl: UILabel!
//    @IBOutlet weak var NotesLbl: UILabel!
    @IBOutlet weak var printLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
