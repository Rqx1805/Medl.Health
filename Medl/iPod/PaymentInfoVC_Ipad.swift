//
//  PaymentInfoVC_Ipad.swift
//  Medl
//
//  Created by mac-15 on 08/01/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class PaymentInfoVC_Ipad: UIViewController {

    @IBOutlet weak var Segment: UISegmentedControl!
       var ns = NSMutableArray()
       var dataArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Segment.selectedSegmentIndex = 1
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
         SocketIoManager.sharedInstance.establishConnection()

    }

    //MARK:-Payment_View_ButtonAction
    @IBAction func PayNowButtonAction(_ sender: MyButton) {
        let vc = Confirmation_Ipad(nibName: "Confirmation_Ipad", bundle: nil)
        self.onlyPushViewController(vc)
    }
    @IBAction func PaylaterButtonAction(_ sender: MyButton) {
        let vc = DashBoard_iPad(nibName: "DashBoard_iPad", bundle: nil)
        self.RootViewControllerWithNav(vc)

    }
    @IBAction func payOnBtnAction(_ sender: Any) {
        let  typeIdArrayString = self.JSONStringify(value: ns as AnyObject)
               print(typeIdArrayString)
              // SocketIoManager.sharedInstance.sendMessage(withSender: typeIdArrayString)
               SocketIoManager.sharedInstance.connectToServerWithRoom(nickname: typeIdArrayString)
               
               NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvert1(_:)), name: NSNotification.Name("notificationNameStudent"), object: nil)
    }
    
    @objc func currencyConvert1(_ pNotification: Notification?) {
           var dictmew = NSArray()
           dictmew = pNotification?.object as! NSArray
           var messgae:String!
           for i in 0..<dictmew.count {
           var dict = NSDictionary()
               dict = dictmew.object(at: i) as! NSDictionary
               messgae = dict.object(forKey: "message") as? String
            }
          
           print(dictmew)
           let vc = DashBoard_iPad(nibName: "DashBoard_iPad", bundle: nil)
           let alert = UIAlertController(title: "", message: messgae, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {action in self.RootViewControllerWithNav(vc)}))
           self.present(alert, animated: true, completion: nil)
      }
       
       func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{

           let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
           if JSONSerialization.isValidJSONObject(value) {
               do{
                   let data = try JSONSerialization.data(withJSONObject: value, options: options)
                   if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                       return string as String
                   }
               }catch {
                   print("error")
               }
           }
           return ""
       }
    
    //MARK:- Navigation Bar Button Action
    @IBAction func BackButtonAction(_ sender: UIButton) {
       // NotificationCenter.default.post(name: NSNotification.Name("CallAddressAPI"), object: nil)
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
        let vc = NotificationVC_iPad(nibName: "NotificationVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
    }
    
    @IBAction func EditAccountButtonAction(_ sender: UIButton) {
        let vc = EditAccount_iPad(nibName: "EditAccount_iPad", bundle: nil)
        self.onlyPushViewController(vc)
        
    }

}
