//
//  SignUpVC_iPad.swift
//  Medl
//
//  Created by mac-15 on 26/11/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class SignUpVC_iPad: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var PhoneNumberTxtField: UITextField!
    @IBOutlet weak var EnterPINTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func LoginButtonAction(_ sender: MyButton) {
        let vc = LoginVC_iPod(nibName: "LoginVC_iPod", bundle: nil)
        self.RootViewControllerWithNav(vc)
        
    }
    @IBAction func SignUpButtonAction(_ sender: MyButton) {
        if ValidationClass().SignInForm_IPAD_Form(self){
            
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
            print(parameterDictionary)
            
            let methodName = "/activateAccount"
            
            getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["sucess"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if success == "1"{
//                        let response = DataManager.getVal(responseData?["response"]) as! [String: Any]
//                        DataManager.saveinDefaults(response)
                        
                        let vc = SignUp2_iPad(nibName: "SignUp2_iPad", bundle: nil)
                        vc.mobileNumber = self.PhoneNumberTxtField.text!
                        self.RootViewControllerWithNav(vc)

                    }else{
                        Config().error(message: message)
                    }
                    
                }
                self.clearHud()
            }
        }
    }
    
    @IBAction func LostPINButtonAction(_ sender: UIButton) {
        
        if ValidationClass().SignInForm_IPAD_Form1(self){
            
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
                    let success = DataManager.getVal(responseData?["sucess"]) as? String ?? ""
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

        
        
        
        //        let vc = LostPINVC_iPad(nibName: "LostPINVC_iPad", bundle: nil)
        //        self.onlyPushViewController(vc)
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
        
       // let vc = LoginNew_iPad(nibName: "LoginNew_iPad", bundle: nil)
      //  self.RootViewControllerWithNav(vc)
        navigationController?.popViewController(animated: true)
        
    }
    
}
