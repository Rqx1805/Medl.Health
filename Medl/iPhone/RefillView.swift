//
//  RefillView.swift
//  Medl
//
//  Created by Ashish Soni on 29/08/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class RefillView: UIView {

    @IBOutlet weak var quantLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var contiuneBtn: UIButton!
    @IBOutlet weak var subTl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var subtotalLbl: UILabel!
    @IBOutlet weak var tabName: UILabel!
    var buttonDonehandler : (()-> Void)?
    var buttonCancelhandler : (()-> Void)?
    var defaults:UserDefaults!
    var tlprice:String!
    var tax:String!
    var cost:String!
    var quant:String!
    var unitpr:Int!
    var medName:String!
    var tylpo:String!
    var actutaldata:String!
    var subdrug:String!
    var substr:String!
    var subPro:String!
    var subDosage:String!
    var subRoute:String!
    class func intitiateFromNib() -> RefillView {
        
        let View1 = UINib.init(nibName: "RefillView", bundle: nil).instantiate(withOwner: self, options: nil).first as! RefillView
        return View1
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        defaults = UserDefaults.standard
        tylpo = defaults.value(forKey: "SUBP") as? String
        if tylpo == "NORPRO" {
             tlprice = defaults.value(forKey: "TLDATA1") as? String
             tax = defaults.value(forKey: "TAXDATA1") as? String
             cost = defaults.value(forKey: "FINALDATA1") as? String
             quant = defaults.value(forKey: "QUANTITYDATA1") as? String
             unitpr = defaults.integer(forKey: "UNITDATA1")
             medName = defaults.value(forKey: "MEDNAME1") as? String
             self.quantLbl.text =   quant
             self.priceLbl.text =  "$" + String(unitpr)
             if self.tax == nil {
                 self.taxLbl.text =  "$" + "0.00"
             }else {
                  self.taxLbl.text =  "$" + tax
             }
            
             self.costLbl.text =  "$" + tlprice
             self.subtotalLbl.text = "$" + cost
             self.subTl.text = "$" + tlprice
             self.tabName.text = medName
        }else {
             tlprice = defaults.value(forKey: "TLDATA") as? String
             actutaldata = defaults.value(forKey: "AutualData") as? String
             tax = defaults.value(forKey: "TAXDATA") as? String
             cost = defaults.value(forKey: "FINALDATA") as? String
             quant = defaults.value(forKey: "QUANTITYDATA") as? String
            // unitpr = defaults.integer(forKey: "UNITDATA")
             medName = defaults.value(forKey: "MEDNAME") as? String
             subRoute = defaults.value(forKey: "SUBROUTE") as? String
             subdrug = defaults.value(forKey: "SUBDRUG") as? String
             subDosage = defaults.value(forKey: "SUBDOSAGE") as? String
             subPro = defaults.value(forKey: "SUBPRODUCT") as? String
             substr = defaults.value(forKey: "SUBSTRENGTH") as? String
             self.quantLbl.text =    quant
             self.priceLbl.text =  "$" + tlprice
             if self.tax == nil {
                 self.taxLbl.text =  "$" + "0.00"
             }else {
                  self.taxLbl.text =  "$" + tax
             }
            
             self.costLbl.text =  "$" + actutaldata
             self.subtotalLbl.text = "$" + cost
             self.subTl.text = "$" + actutaldata
             self.tabName.text = medName
        }
        
        
        contiuneBtn.layer.cornerRadius = 18
        
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        buttonCancelhandler?()
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
         buttonDonehandler?()
    }
}
