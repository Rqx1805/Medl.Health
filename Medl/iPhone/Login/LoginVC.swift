//
//  LoginVC.swift
//  MEDAL
//
//  Created by mac-15 on 22/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit
import EasyTipView
class LoginVC: UIViewController,UITextFieldDelegate,EasyTipViewDelegate {
   
    
    
    @IBOutlet weak var EmailTxtField: UITextField!
    @IBOutlet weak var PasswordTxtField: FloatLabelTextField!
    var loginVCID: String!
    let isBlurUI = true
    let story_board = UIStoryboard(name: "Main", bundle: nil)
    var str_deviceid:String!
    var defaults:UserDefaults!
    weak var tipView: EasyTipView?
    @IBOutlet weak var buttonB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.EmailTxtField.text = "1 (868)"
      //  EmailTxtField.delegate = self
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(red: 25/255, green: 51/255, blue: 86/255, alpha: 1.0)
        
        EasyTipView.globalPreferences = preferences
        self.view.backgroundColor = UIColor(hue:0.75, saturation:0.01, brightness:0.96, alpha:1.00)
        
        defaults = UserDefaults.standard
        str_deviceid = defaults.value(forKey:"Devicetoken") as? String
        self.navigationController?.isNavigationBarHidden = true
//        self.loginVCID = self.isBlurUI ? "BlurPasswordLoginViewController" : "PasswordLoginViewController"
//        self.EmailTxtField.text = "rahul@mailinator.com"
//        self.PasswordTxtField.text = "patient"
    }
    
   
    
    
    
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
           print("\(tipView) did dismiss!")
       }
    
    @IBAction func LoginButtonAction(_ sender: MyButton) {
        
        if ValidationClass().ValidateLoginEmailForm(self){
            
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
                        let vc = DashBoard(nibName: "DashBoard", bundle: nil)
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
        let vc = ForgotPasswordVC(nibName: "ForgotPasswordVC", bundle: nil)
        self.onlyPushViewController(vc)
    }
    @IBAction func EnterPinButtonAction(_ sender: UIButton) {
        //self.present(self.loginVCID)
        let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
        self.onlyPushViewController(vc)
        

    }
  
    @IBAction func iBtnAction(_ sender: Any) {
        var preferences = EasyTipView.globalPreferences
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.font = UIFont(name: "HelveticaNeue-Light", size: 14)!
        preferences.drawing.textAlignment = NSTextAlignment.justified
   
        preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: 15)
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = 1
        preferences.animating.dismissDuration = 1
        preferences.drawing.arrowPosition = .top
   
       let text = "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character."
       EasyTipView.show(forView: self.buttonB,
       withinSuperview: self.navigationController?.view,
       text: text,
       preferences: preferences)
    }
    func present(_ id: String) {
        
        let obj = story_board.instantiateViewController(withIdentifier: "BlurPasswordLoginViewController") as! BlurPasswordLoginViewController
        obj.modalPresentationStyle = .overCurrentContext
        self.presentViewController(obj)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         
    }
    
   // func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
      //  if textField.text!.count > 7 {
         //  textField.isEnabled = true
       // }else  if textField.text!.count == 7 {
         //    textField.isEnabled = true
     //   }
     //   else {
         //    textField.isEnabled = false
       // }
        
       // if range.length == 1  && range.location == 6 {
         //   let changedText = NSString(string: textField.text!)
          //  if changedText.contains("1 (868)") {
               
             //   return false
          //  }
      //  }else if range.length == 1  && range.location == 5 {
         //  let changedText = NSString(string: textField.text!)
           // if changedText.contains("1 (868)") {
                 
              //  return false
         //   }
      //  }else if range.length == 1  && range.location == 4 {
        //   let changedText = NSString(string: textField.text!)
          //  if changedText.contains("1 (868)") {
                 
            //    return false
        //    }
       // }else if range.length == 1  && range.location == 3 {
         //  let changedText = NSString(string: textField.text!)
         //   if changedText.contains("1 (868)") {
                 
          //      return false
         //   }
    //    }else if range.length == 1  && range.location == 2 {
         //   let changedText = NSString(string: textField.text!)
          //  if changedText.contains("1 (868)") {
                 
          //      return false
        //    }
     //   }else if range.length == 1  && range.location == 1 {
         //   let changedText = NSString(string: textField.text!)
        //    if changedText.contains("1 (868)") {
                
           //     return false
         //   }
      //  }
      //  else if range.length == 1  && range.location == 0 {
        //    let changedText = NSString(string: textField.text!)
         //   if changedText.contains("1 (868)") {
                 
            //    return false
           // }
      //  }
         
      //  return true
   // }
    
   
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
