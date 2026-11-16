//
//  SignUpVC.swift
//  Medl
//
//  Created by mac-15 on 28/11/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var PhoneNumberTxtField: FloatLabelTextField!
    @IBOutlet weak var EnterPINTxtField: FloatLabelTextField!
    var mobileNumber = String()
    var str_deviceid:String!
    var defaults:UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults = UserDefaults.standard
        str_deviceid = defaults.value(forKey:"Devicetoken") as? String
        
        self.navigationController?.isNavigationBarHidden = true
        
//        self.PhoneNumberTxtField.text = "1 (868)"
//        PhoneNumberTxtField.delegate = self
        
    }
    
//    @IBAction func LoginButtonAction(_ sender: MyButton) {
//        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
//        self.RootViewControllerWithNav(vc)
//
//    }
    @IBAction func SignInButtonAction(_ sender: MyButton) {
        
        if ValidationClass().SignInForm_Form(self){
            
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            var str:String!
            str = self.PhoneNumberTxtField.text!
            var newstr:String!
            newstr = "1868"
            var newstr2:String!
            newstr2 = newstr + str
            print(newstr2!)
            parameterDictionary.setValue(DataManager.getVal(self.EnterPINTxtField.text!), forKey: "otp")
            parameterDictionary.setValue(DataManager.getVal(newstr2), forKey: "mobile")
            parameterDictionary.setValue(DataManager.getVal(str_deviceid), forKey: "deviceId")
            print(parameterDictionary)
            
            let methodName = "/activateAccount"
            
            getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if success == "1"{
                        //let response = DataManager.getVal(responseData?["response"]) as! [String: Any]
                        //DataManager.saveinDefaults(response)
                        Config().success(message: message)
                        let vc = SignUp1VC(nibName: "SignUp1VC", bundle: nil)
                        var str:String!
                        str = self.PhoneNumberTxtField.text!
                        var newstr:String!
                        newstr = "1868"
                        var newstr2:String!
                        newstr2 = newstr + str
                        vc.mobileNumber = newstr2
                        self.onlyPushViewController(vc)
                    }else{
                        Config().error(message: message)
                    }
                    
                }
                self.clearHud()
            }
        }
    }
    @IBAction func LostPinButtonAction(_ sender: UIButton) {
        
        
        if ValidationClass().SignInForm_Form1(self){
            
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            var str:String!
            str = self.PhoneNumberTxtField.text!
            var newstr:String!
            newstr = "1868"
            var newstr2:String!
            newstr2 = newstr + str
            print(newstr2!)
            parameterDictionary.setValue(DataManager.getVal(newstr2), forKey: "mobile")
            print(parameterDictionary)
            
            let methodName = "/registerOtp"
            
            getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if success == "1"{
                        //let response = DataManager.getVal(responseData?["response"]) as! [String: Any]
                        //DataManager.saveinDefaults
                        Config().success(message: message)
                    }else{
                        Config().error(message: message)
                    }
                    
                }
                self.clearHud()
            }
        }

        
        //let vc = ForgotPasswordVC(nibName: "ForgotPasswordVC", bundle: nil)
      //  self.onlyPushViewController(vc)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == PhoneNumberTxtField{
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
           let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
           return count <= 15

       }

        return true
    }
    
   

    
    @IBAction func navBack(_ sender: Any) {
        
//        let vc = LoginNew(nibName: "LoginNew", bundle: nil)
//        self.RootViewControllerWithNav(vc)
        navigationController?.popViewController(animated: true)
    }
    
    
}
//@IBAction func navBack(_ sender: MyButton) {
//
//    self.navigationController?.popViewController(animated: true)
//
//}
