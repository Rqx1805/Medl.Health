//
//  ConfirmYourOrderVC.swift
//  Medl
//
//  Created by mac-15 on 23/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class ConfirmYourOrderVC: BaseBackViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var ORDERTBLVIEW: UITableView!
    @IBOutlet weak var OrderTblHeightConstraint: NSLayoutConstraint!//150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let Pending_nibClass = UINib(nibName: "ConfirmOrderTableCell", bundle: nil)
        self.ORDERTBLVIEW.register(Pending_nibClass, forCellReuseIdentifier: "ConfirmOrderTableCell")
        self.ORDERTBLVIEW.estimatedRowHeight = 60
        self.ORDERTBLVIEW.rowHeight = UITableView.automaticDimension
        self.ORDERTBLVIEW.dataSource = self
        self.ORDERTBLVIEW.delegate = self
        self.ORDERTBLVIEW.tableFooterView = UIView()
        self.ORDERTBLVIEW.sectionHeaderHeight = 0
        self.ORDERTBLVIEW.separatorStyle = .none
        self.OrderTblHeightConstraint.constant = 90*6
    }
    
    @IBAction func DelivertoEditButtonAction(_ sender: UIButton) {
    }
    @IBAction func PaymentInfoEitButtonAction(_ sender: UIButton) {
    }
    @IBAction func ConfirmOrderButtonAction(_ sender: MyButton) {
        let vc = SelectCardVC(nibName: "SelectCardVC", bundle: nil)
        self.onlyPushViewController(vc)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (Config().shownIndexes.contains(indexPath) == false) {
            Config().shownIndexes.append(indexPath)
            
            cell.transform = CGAffineTransform(translationX: 0, y: Config().CELL_HEIGHT)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.alpha = 0
            
            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(0.5)
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            UIView.commitAnimations()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmOrderTableCell", for: indexPath) as! ConfirmOrderTableCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
