//
//  Confirmation_Ipad.swift
//  Medl
//
//  Created by mac-15 on 08/01/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class Confirmation_Ipad: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK:-DeliveryInfoView
    @IBOutlet weak var OrderTblView: UITableView!
    @IBOutlet weak var Segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.Segment.selectedSegmentIndex = 2
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate

        let Pending_nibClass = UINib(nibName: "ConfirmOrderTableCell", bundle: nil)
        self.OrderTblView.register(Pending_nibClass, forCellReuseIdentifier: "ConfirmOrderTableCell")
        self.OrderTblView.estimatedRowHeight = 60
        self.OrderTblView.rowHeight = UITableView.automaticDimension
        self.OrderTblView.dataSource = self
        self.OrderTblView.delegate = self
        self.OrderTblView.tableFooterView = UIView()
        self.OrderTblView.sectionHeaderHeight = 0
        self.OrderTblView.separatorStyle = .none

    }

    //MARK:-Tableview Delegete
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
        return 25
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmOrderTableCell", for: indexPath) as! ConfirmOrderTableCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //MARK:- Navigation Bar Button Action
    @IBAction func BackButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ConfirmOrderButtonAction(_ sender: MyButton) {
        let vc = ThankYou_iPad(nibName: "ThankYou_iPad", bundle: nil)
        self.presentViewController(vc)
    }
    
    @IBAction func LogOutButtonAction(_ sender: UIButton) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("Yes", backgroundColor: Config().AppNavBlueColor){
            Config().AppUserDefaults.set("no", forKey: "login")
            
            let vc = LoginVC_iPod(nibName: "LoginVC_iPod", bundle: nil)
            self.RootViewControllerWithNav(vc)
        }
        alert.addButton("No", backgroundColor: Config().AppNavBlueColor){
            print("No")
        }
        alert.showEdit("Logout", subTitle: "Are you sure you want to logout?")
        
    }
    @IBAction func SupportButtonAction(_ sender: UIButton) {
        let vc = SupportVC_iPad(nibName: "SupportVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
        
    }
    @IBAction func NotificationButtonAction(_ sender: UIButton) {
        let vc = NotificationVC_iPad(nibName: "NotificationVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
    }
    
    @IBAction func EditAccountButtonAction(_ sender: UIButton) {
        let vc = EditAccount_iPad(nibName: "EditAccount_iPad", bundle: nil)
        self.onlyPushViewController(vc)
        
    }


}
