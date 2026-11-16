//
//  SelectCardVC.swift
//  Medl
//
//  Created by mac-15 on 24/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class SelectCardVC: BaseBackViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var CardTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibClass = UINib(nibName: "CardTableCell", bundle: nil)
        self.CardTblView.register(nibClass, forCellReuseIdentifier: "CardTableCell")
        self.CardTblView.estimatedRowHeight = 60
        self.CardTblView.rowHeight = UITableView.automaticDimension
        self.CardTblView.dataSource = self
        self.CardTblView.delegate = self
        self.CardTblView.tableFooterView = UIView()
        self.CardTblView.sectionHeaderHeight = 0
        self.CardTblView.separatorStyle = .none
        
    }
    
    @IBAction func AddNewCardButtonAction(_ sender: MyButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func NextButtonAction(_ sender: MyButton) {
        let vc = ThankYouVC(nibName: "ThankYouVC", bundle: nil)
        self.presentViewController(vc)
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
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableCell", for: indexPath) as! CardTableCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
