//
//  PaymentDetailsVC.swift
//  Medl
//
//  Created by mac-15 on 23/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class PaymentDetailsVC: BaseBackViewController {
    
    var ns = NSMutableArray()
    var dataArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SocketIoManager.sharedInstance.establishConnection()
        
    }
    
    @IBAction func PayNowButtonAction(_ sender: MyButton) {
        let vc = ConfirmYourOrderVC(nibName: "ConfirmYourOrderVC", bundle: nil)
        self.onlyPushViewController(vc)
        
    }
    @IBAction func PaylaterButtonAction(_ sender: MyButton) {
        
//        let defaults   = UserDefaults.standard
//        let savedArray = defaults.object(forKey: "Array") as? [String] ?? [String]()
//        let  typeIdArrayString = self.JSONStringify(value: ns as AnyObject)
//        print(typeIdArrayString)
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
        let vc = DashBoard(nibName: "DashBoard", bundle: nil)
        let messageFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 15.0)!]
        let messageAttrString = NSMutableAttributedString(string: messgae, attributes: messageFont)


        let alert = UIAlertController(title: "", message: messgae, preferredStyle: UIAlertController.Style.alert)
        alert.setValue(messageAttrString, forKey: "attributedMessage")

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
    
    
}
