//
//  ChangePasswordVC.swift
//  Medl
//
//  Created by mac-15 on 08/01/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit
import MKToolTip
import CRNotifications
class ChangePasswordVC: UIViewController  {

    @IBOutlet weak var OldTxtField: FloatLabelTextField!
    @IBOutlet weak var NewPTxtField: FloatLabelTextField!
    @IBOutlet weak var ConfirmTxtField: FloatLabelTextField!
    @IBOutlet weak var buttonB: UIButton!
    var stroldpass:NSString!
    var strnewpass:NSString!
    var strrenewpass:NSString!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Change Password"
        
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

    func error(message: String){
        CRNotifications.showNotification(type: CRNotifications.error, title: "Error", message: message, dismissDelay: 3)
    }
    
   

    @IBAction func SubmitButtonAction(_ sender: MyButton) {
        
       // if ValidationClass().Validate_Changepassword_Form(self){
            stroldpass = OldTxtField.text! as NSString
            strnewpass = NewPTxtField.text! as NSString
            strrenewpass = ConfirmTxtField.text! as NSString
            
            if stroldpass .isEqual(to: "") {
              self.error(message: "Please enter your old password.")
           }else if strnewpass .isEqual(to: "") {
               self.error(message: "Please enter your new password.")
           }else if isValidPWDNew(strnewpass as String) {
               self.error(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
           }else if strrenewpass .isEqual(to: "") {
               self.error(message: "Please enter your confirm password.")
           }else if isValidPWDNew(strrenewpass as String) {
               self.error(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
           }else if (strnewpass != strrenewpass) {
               self.error(message: "Your new password and confirm password does not match.")
            }else {
        
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(DataManager.getVal(self.OldTxtField.text!), forKey: "oldPassword")
            parameterDictionary.setValue(DataManager.getVal(self.NewPTxtField.text!), forKey: "password")
            print(parameterDictionary)
            
            let methodName = "/updatePassword"
            
            getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if success == "1"{
                        let vc = DashBoard(nibName: "DashBoard", bundle: nil)
                        self.RootViewControllerWithNav(vc)
                        Config().success(message: message)
                    }else{
                        Config().error(message: message)
                    }
                    
                }
                self.clearHud()
            }
        }
       // }

    }
    
    func isValidPWDNew(_ PwdStr:String) -> Bool {
           let emailRegEx =  "([(0-9)(A-Z)(!@#$%ˆ&*+-=<>)]+)([a-z]*){8,15}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           let result = emailTest.evaluate(with: PwdStr)
           return result
       }
    

}
