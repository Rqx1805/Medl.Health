//
//  EnterNewPasswordVC_iPad.swift
//  Medl
//
//  Created by mac-15 on 26/11/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class EnterNewPasswordVC_iPad: UIViewController {
    
    @IBOutlet weak var OtpTxtField: UITextField!
    
    
    var email_str = String()
    var data_str = String()
    var mobile_str = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
    }
    @IBAction func BackButtonAction(_ sender: MyButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ResendOTPButtonAction(_ sender: UIButton) {
        self.showHud()
        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(DataManager.getVal(self.mobile_str), forKey: "mobile")
        print(parameterDictionary)
        
        let methodName = "/resendOtp"
        
        getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
            if error == nil{
                
                let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                
                if success == "1"{
                    Config().success(message: "New OTP is send to your register mail id")
                }else{
                    Config().error(message: message)
                }
                
            }
            self.clearHud()
        }
        
    }
    
    @IBAction func NextButtonAction(_ sender: MyButton) {
        
        if ValidationClass().Validate_OTP_IPADForm(self){
             self.showHud()
            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(DataManager.getVal(self.OtpTxtField.text!), forKey: "otp")
            parameterDictionary.setValue(DataManager.getVal(self.email_str), forKey: "email")

            print(parameterDictionary)
            
            let methodName = "/verifyotp"
            
            getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if success == "1"{
                        let vc = ResetPasswordVC(nibName: "ResetPasswordVC", bundle: nil)
                        vc.data_str = self.data_str
                        self.onlyPushViewController(vc)
                    }else{
                        Config().error(message: message)
                    }
                }
                self.clearHud()
            }
        }
        
        
//        if ValidationClass().Validate_OTP_IPADForm(self){
//            
//            self.showHud()
//            let parameterDictionary = NSMutableDictionary()
//            parameterDictionary.setValue(DataManager.getVal(self.NewPasswordTxtField.text!), forKey: "password")
//            parameterDictionary.setValue(DataManager.getVal(self.OtpTxtField.text!), forKey: "otp")
//            print(parameterDictionary)
//            
//            let methodName = "/resetPassword/\(data_str)"
//            
//            getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
//                if error == nil{
//                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
//                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
//                    
//                    if success == "1"{
//                        let vc = LoginVC_iPod(nibName: "LoginVC_iPod", bundle: nil)
//                        self.RootViewControllerWithNav(vc)
//                        Config().success(message: message)
//                    }else{
//                        Config().error(message: message)
//                    }
//                    
//                }
//                self.clearHud()
//            }
//        }
        
    }
}

