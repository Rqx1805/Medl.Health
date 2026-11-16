//
//  ChangePasswordVC_iPad.swift
//  Medl
//
//  Created by mac-15 on 29/11/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit
import Alamofire
class ChangePasswordVC_iPad: UIViewController {
    
    @IBOutlet weak var OldPasswordTxtField: UITextField!
    @IBOutlet weak var NewPasswordTxtField: UITextField!
    @IBOutlet weak var ConfirmPassowordTxtField: UITextField!
    
    var defaults:UserDefaults!
    var status:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
    }
    
    @IBAction func BackButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SubmitButtonAction(_ sender: UIButton) {
        
        if ValidationClass().Validate_Changepassword_IPADForm(self){
            
            self.showHud()
            
            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(DataManager.getVal(self.OldPasswordTxtField.text!), forKey: "oldPassword")
            parameterDictionary.setValue(DataManager.getVal(self.NewPasswordTxtField.text!), forKey: "password")
            print(parameterDictionary)
            
            let methodName = "/updatePassword"
            
            getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                                        
                    if success == "1"{
                        let vc = DashBoard_iPad(nibName: "DashBoard_iPad", bundle: nil)
                        self.RootViewControllerWithNav(vc)
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
