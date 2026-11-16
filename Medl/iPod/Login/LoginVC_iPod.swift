//
//  LoginVC_iPod.swift
//  MEDAL
//
//  Created by mac-15 on 22/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit
import CRNotifications
class LoginVC_iPod: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var EmailTxtField: UITextField!
    @IBOutlet weak var PasswordTxtField: UITextField!
    var loginVCID: String!
    let isBlurUI = true
    let story_board = UIStoryboard(name: "Main", bundle: nil)
    var defaults:UserDefaults!
    var status:Int!
    var str_deviceid:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults = UserDefaults.standard
        str_deviceid = defaults.value(forKey:"Devicetoken") as? String
        self.navigationController?.isNavigationBarHidden = true
        
      
        
//        self.loginVCID = self.isBlurUI ? "BlurPasswordLoginViewController" : "PasswordLoginViewController"
        
//        self.EmailTxtField.text = "rahul@mailinator.com"
//        self.PasswordTxtField.text = "patient"
        
    }
    
    @IBAction func LoginButtonAction(_ sender: MyButton) {
        
        if ValidationClass().ValidateLoginIPADForm(self){
            
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            var str:String!
            str = self.EmailTxtField.text!
            var newstr:String!
            newstr = "1868"
            var newstr2:String!
            newstr2 = newstr + str
            print(newstr2!)
            parameterDictionary.setValue(DataManager.getVal(newstr2), forKey: "email")
            parameterDictionary.setValue(DataManager.getVal(self.PasswordTxtField.text!), forKey: "password")
            parameterDictionary.setValue(DataManager.getVal(str_deviceid), forKey: "deviceId")
            print(parameterDictionary)
            
            let methodName = "/patientLogin"
            
            getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if let user = DataManager.getVal(responseData?["user"]) as? [String : Any]{
                        DataManager.saveinDefaults(user)
                        
                        let _id = DataManager.getVal(user["_id"]) as? String ?? ""
                        let defaults = UserDefaults.standard
                        defaults.setValue(_id, forKey: "iduser")
                        defaults.synchronize()
                    }
                    
                    let token = DataManager.getVal(responseData?["token"]) as? String ?? ""
                    Config().AppUserDefaults.set(token, forKey: "token")
                    

                    if success == "1"{
                        Config().AppUserDefaults.set("yes", forKey: "login")
                        let vc = DashBoard_iPad(nibName: "DashBoard_iPad", bundle: nil)
                        self.RootViewControllerWithNav(vc)

                    }else{
                        Config().error(message: message)
                    }
                }
                self.clearHud()
            }
           
        }
        
    }
    @IBAction func ForgotPasswordButtonAction(_ sender: UIButton) {
        let vc = LostPINVC_iPad(nibName: "LostPINVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
    }
    @IBAction func EnterPinButtonAction(_ sender: UIButton) {
        //present(loginVCID)
        let vc = SignUpVC_iPad(nibName: "SignUpVC_iPad", bundle: nil)
        self.RootViewControllerWithNav(vc)
    }
    
    @IBAction func signUpBtnaction(_ sender: Any) {
        let vc = SignUpVC_iPad(nibName: "SignUpVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
    }
    
    func present(_ id: String) {
        
        let obj = story_board.instantiateViewController(withIdentifier: "BlurPasswordLoginViewController") as! BlurPasswordLoginViewController
        obj.modalPresentationStyle = .overCurrentContext
        self.presentViewController(obj)
    }
    
    
   
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == EmailTxtField{
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

    
}
