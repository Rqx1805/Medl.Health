//
//  LostPINVC_iPad.swift
//  Medl
//
//  Created by mac-15 on 26/11/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class LostPINVC_iPad: UIViewController {
    
    @IBOutlet weak var EmailAddressTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        //self.EmailAddressTxtField.text = "patienttestdummy@gmail.com"
    }
    @IBAction func BackButtonAction(_ sender: MyButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func NextButtonAction(_ sender: MyButton) {
        
        if ValidationClass().ValidateLostPinIPADForm(self){
            
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(DataManager.getVal(self.EmailAddressTxtField.text!), forKey: "email")
            print(parameterDictionary)
            
            let methodName = "/forgetPassword"
            
            getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
                if error == nil{
                    let status = DataManager.getVal(responseData?["status"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    let data  = DataManager.getVal(responseData?["data"]) as? String ?? ""
                    let mobile  = DataManager.getVal(responseData?["mobile"]) as? String ?? ""
                    
                    if status == "1"{
                        let vc = EnterNewPasswordVC_iPad(nibName: "EnterNewPasswordVC_iPad", bundle: nil)
                        vc.email_str = self.EmailAddressTxtField.text!
                        vc.data_str = data
                        vc.mobile_str = mobile
                        self.onlyPushViewController(vc)
                        Config().success(message: message)
                        
                    }else{
                        Config().error(message: message)
                    }
                    
                }
                self.clearHud()
            }
            
        }
    }
}
