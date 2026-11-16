//
//  SignUp1VC.swift
//  Medl
//
//  Created by mac-15 on 09/01/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit
import MKToolTip
import CRNotifications
class SignUp1VC: UIViewController,UITextFieldDelegate  {

    @IBOutlet weak var EmailAddressTxtField: FloatLabelTextField!
    @IBOutlet weak var PasswordTxtField: FloatLabelTextField!
    @IBOutlet weak var ReEnterPasswordTxtField: FloatLabelTextField!
    var mobileNumber = String()
    @IBOutlet weak var checkBtn: UIButton!
        var str_deviceid:String!
        var defaults:UserDefaults!
     var isclick: Bool = false
    var strEmail:NSString!
    var strPass:NSString!
    var strRePass:NSString!
     var termndCondition = NSString()
     @IBOutlet weak var buttonB: UIButton!
    
    @objc func Resgistration(_ notification: Notification) {
          
           let success = notification.userInfo?["sucess"] as? Int ?? 0
           let message =  notification.userInfo?["message"] as? String ?? ""
           
           DispatchQueue.main.async() {
               if success == 0 {
                  Config().error(message: message)
                  self.clearHud()
                  NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SignUpMedlNotification"), object: nil)
               }
               else{
                var data = String()
                data = (notification.userInfo?["data"] as? String)!
               // let data = DataManager.getVal(responseData?["data"]) as? String ?? ""

                if let user = notification.userInfo?["user"] as? [String : Any]{
                 let _id = DataManager.getVal(user["_id"]) as? String ?? ""
                 let defaults = UserDefaults.standard
                 defaults.setValue(_id, forKey: "iduser")
                 defaults.synchronize()
                 }

                 Config().AppUserDefaults.set(data, forKey: "token")

                 let vc = DashBoard(nibName: "DashBoard", bundle: nil)
                 self.RootViewControllerWithNav(vc)
                 self.clearHud()
                 NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SignUpMedlNotification"), object: nil)
                   
               }
           }
       }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults = UserDefaults.standard
        str_deviceid = defaults.value(forKey:"Devicetoken") as? String
      
//        defaults = UserDefaults.standard
//        str_deviceid = defaults.value(forKey:"Devicetoken") as? String
        self.navigationController?.isNavigationBarHidden = true
        termndCondition = "No"
    }
     @IBAction func iBtnAction(_ sender: UIButton) {
        let preference = ToolTipPreferences()
        preference.drawing.bubble.color = UIColor(red: 25/255, green: 51/255, blue: 86/255, alpha: 1.0)
        preference.drawing.bubble.spacing = 10
        preference.drawing.bubble.cornerRadius = 5
        preference.drawing.bubble.inset = 15
        preference.drawing.bubble.border.color = UIColor(red: 25/255, green: 51/255, blue: 86/255, alpha: 1.0)
        preference.drawing.bubble.border.width = 1
        preference.drawing.arrow.tipCornerRadius = 5
        preference.drawing.message.color = UIColor.white
        preference.drawing.message.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        preference.drawing.button.color = UIColor(red: 0.074, green: 0.231, blue: 0.431, alpha: 1.000)
        preference.drawing.button.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        sender.showToolTip(identifier: "", message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.", button: "", arrowPosition: .top, preferences: preference, delegate: nil)
     }

   
    @IBAction func BackButtonAction(_ sender: MyButton) {

        self.navigationController?.popViewController(animated: true)
    }
    func error(message: String){
        CRNotifications.showNotification(type: CRNotifications.error, title: "Error", message: message, dismissDelay: 3)
    }
    
    func isValidPassword(_ testStr:String) -> Bool {
           let emailRegEx = "([(0-9)(A-Z)(!@#$%ˆ&*+-=<>)]+)([a-z]*){8,15}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           let result = emailTest.evaluate(with: testStr)
           return result
       }
    
    @IBAction func SignInButtonAction(_ sender: MyButton) {
        strEmail = EmailAddressTxtField.text! as NSString
         strPass = PasswordTxtField.text! as NSString
         self.showHud()
         if ValidationClass().SignIn1Form_Form(self){
            self.showHud()
            Parsing().SignUpMedl(Email: strEmail as String?, Password: strPass as String?, Mobile: mobileNumber, DeviceId: str_deviceid)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SignUpMedlNotification"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.Resgistration), name: NSNotification.Name(rawValue: "SignUpMedlNotification"), object: nil)
            
         }else {
            self.clearHud()
        }
        
        
//        strPass = PasswordTxtField.text as NSString?
//        if ValidationClass().SignIn1Form_Form(self){
//            if isValidPassword(strPass as String) {
//                self.error(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
//            }else {
//                           self.showHud()
//                           let parameterDictionary = NSMutableDictionary()
//                           parameterDictionary.setValue(DataManager.getVal(self.EmailAddressTxtField.text!), forKey: "email")
//                           parameterDictionary.setValue(DataManager.getVal(self.PasswordTxtField.text!), forKey: "password")
//                           parameterDictionary.setValue(DataManager.getVal(self.mobileNumber), forKey: "mobile")
//                           parameterDictionary.setValue(DataManager.getVal(self.str_deviceid), forKey: "deviceId")
//
//                           print(parameterDictionary)
//
//                           let methodName = "/updateDetail"
//
//                               self.getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
//                              // if error == nil{
//                                   let success = DataManager.getVal(responseData?["sucess"]) as? String ?? ""
//                                   let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
//
//                                   if success == "1"{
//                                       let data = DataManager.getVal(responseData?["data"]) as? String ?? ""
//
//                                      if let user = DataManager.getVal(responseData?["user"]) as? [String : Any]{
//                                       let _id = DataManager.getVal(user["_id"]) as? String ?? ""
//                                       let defaults = UserDefaults.standard
//                                       defaults.setValue(_id, forKey: "iduser")
//                                       defaults.synchronize()
//                                       }
//
//                                       Config().AppUserDefaults.set(data, forKey: "token")
//
//                                       let vc = DashBoard(nibName: "DashBoard", bundle: nil)
//                                       self.RootViewControllerWithNav(vc)
//                                       self.clearHud()
//
//                                   }else{
//                                       Config().error(message: message)
//                                       self.clearHud()
//                                   }
//                       }
//            }
//
//        }
    }

    
    @IBAction func checkBtnAction(_ sender: Any) {
        if (!isclick){
            checkBtn.setBackgroundImage(UIImage(named: "checkbox-2"), for: .normal)
            isclick=true
            termndCondition = "yes"
        }
        else
        {
            checkBtn.setBackgroundImage(UIImage(named: "checkbox-2-1"), for: .normal)
            isclick=false
            termndCondition = "No"
        }
    }
    @IBAction func termBtnAction(_ sender: Any) {
       let vc = Terms_ConditionsViewController(nibName: "Terms_ConditionsViewController", bundle: nil)

       self.onlyPushViewController(vc)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == EmailAddressTxtField{
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 60
        }
        
        return true
    }
    
  

    
    @IBAction func navBack(_ sender: Any) {
        
        let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
        self.RootViewControllerWithNav(vc)
    }
    
    
    
}
