//
//  NotificationVC_iPad.swift
//  Medl
//
//  Created by mac-15 on 26/11/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class NotificationVC_iPad: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var NotificationTblView: UITableView!
     var data_Array = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        let nibClass = UINib(nibName: "NotificationTableCell", bundle: nil)
        self.NotificationTblView.register(nibClass, forCellReuseIdentifier: "NotificationTableCell")
        self.NotificationTblView.estimatedRowHeight = 60
        self.NotificationTblView.rowHeight = UITableView.automaticDimension
        self.NotificationTblView.dataSource = self
        self.NotificationTblView.delegate = self
        self.NotificationTblView.tableFooterView = UIView()
        self.NotificationTblView.sectionHeaderHeight = 0
        self.NotificationTblView.separatorStyle = .none
        
        
         self.Notificationmsg_API(status: "Active")
        
    }
    
    
    func Notificationmsg_API(status: String){
           
           self.showHud()
           let parameterDictionary = NSMutableDictionary()
           print(parameterDictionary)
           
           let methodName = "/getNotifications"
           
           getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
               if error == nil{
                   let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                   let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                   DispatchQueue.main.async {
                       if success == "1"{
                           
                           self.data_Array = DataManager.getVal(responseData?.object(forKey: "data")) as? [Any] ?? []
                           
                           self.NotificationTblView.reloadData()
                       }else{
                           Config().error(message: message)
                       }
                       
                   }
                   self.clearHud()
               }
           }
       }
    
    //MARK:- Navigation Bar Button Action
    @IBAction func BackButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    }
    
    @IBAction func EditAccountButtonAction(_ sender: UIButton) {
        let vc = EditAccount_iPad(nibName: "EditAccount_iPad", bundle: nil)
        self.onlyPushViewController(vc)
        
    }
   func numberOfSections(in tableView: UITableView) -> Int {
          var numOfSections: Int = 0
          if data_Array.count>0
          {
              tableView.separatorStyle = .none
              numOfSections            = 1
              tableView.backgroundView = nil
          }
          else
          {
              let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
              noDataLabel.text          = "No Data Found"
              noDataLabel.textColor     = UIColor.black
              noDataLabel.textAlignment = .center
              tableView.backgroundView  = noDataLabel
              tableView.separatorStyle  = .none
          }
          return numOfSections
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
          return data_Array.count
      }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableCell", for: indexPath) as! NotificationTableCell
          let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
          //let msg_dict = DataManager.getVal(dict["messageId"]) as! NSDictionary
          let message = DataManager.getVal(dict["body"]) as? String ?? ""
          cell.notificationMsgLbl.text = message
          let time = DataManager.getVal(dict["createdAt"]) as? String ?? ""
       if let unixTime = Double(time) {
           let date = Date(timeIntervalSince1970: unixTime)
           let dateFormatter = DateFormatter()
           let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
           dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
           dateFormatter.locale = NSLocale.current
           dateFormatter.dateFormat = "dd.MM.yyyy HH:mm" //Specify your format that you want
          cell.notificationTimeLbl.text = dateFormatter.string(from: date)
       }

          
          return cell
      }
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

          let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
          view.backgroundColor = Config().AppWhiteColor
          let border = UILabel(frame: CGRect(x: 0, y: 40, width: view.frame.size.width, height: 1))
          border.backgroundColor = Config().AppGrayColor
          let label = UILabel(frame: CGRect(x: 135, y: 0, width: 250, height: 40))
   //       let msg_dict = DataManager.getVal(self.data_Array) as! NSDictionary
          label.text = "Notification"
          label.font = UIFont.boldSystemFont(ofSize: 20)
          label.textColor = Config().AppBlackColor

          
          view.addSubview(label)
          view.addSubview(border)

          return view
      }
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 40
      }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
      }
}
