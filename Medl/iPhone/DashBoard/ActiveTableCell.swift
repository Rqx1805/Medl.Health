//
//  ActiveTableCell.swift
//  Medl
//
//  Created by mac-15 on 23/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class ActiveTableCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var DoctorNameLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var routeLbl: UILabel!
    @IBOutlet weak var frequencyLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var refillsLbl: UILabel!
    @IBOutlet weak var NotesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
