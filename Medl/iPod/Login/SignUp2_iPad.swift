//
//  SignUp2_iPad.swift
//  Medl
//
//  Created by mac-15 on 09/01/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class SignUp2_iPad: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var EmailTxtField: UITextField!
    @IBOutlet weak var EnterPasswordTxtField: UITextField!
    @IBOutlet weak var ReEnterPasswordTxtField: UITextField!
    var mobileNumber = String()
    var str_deviceid:String!
    var defaults:UserDefaults!
    @IBOutlet weak var checkBtnIpad: UIButton!
    var isclick: Bool = false
    var termndCondition = NSString()
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults = UserDefaults.standard
        str_deviceid = defaults.value(forKey:"Devicetoken") as? String
        self.navigationController?.isNavigationBarHidden = true
        termndCondition = "No"
    }

    @IBAction func BackButtonAction(_ sender: MyButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func checkBtnIpadAction(_ sender: Any) {
        if (!isclick){
            checkBtnIpad.setBackgroundImage(UIImage(named: "checkbox-2"), for: .normal)
            isclick=true
            termndCondition = "yes"
        }
        else
        {
            checkBtnIpad.setBackgroundImage(UIImage(named: "checkbox-2-1"), for: .normal)
            isclick=false
            termndCondition = "No"
        }
    }
    @IBAction func termsIpadbtnAction(_ sender: Any) {
        let vc = TermsConditionsIPADViewController(nibName: "TermsConditionsIPADViewController", bundle: nil)
        self.onlyPushViewController(vc)
    }
    @IBAction func SignUpButtonAction(_ sender: MyButton) {
        if ValidationClass().SignIn2Form_IPAD_Form(self){
            
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(DataManager.getVal(self.EmailTxtField.text!), forKey: "email")
            parameterDictionary.setValue(DataManager.getVal(self.EnterPasswordTxtField.text!), forKey: "password")
            parameterDictionary.setValue(DataManager.getVal(self.mobileNumber), forKey: "mobile")
            parameterDictionary.setValue(DataManager.getVal(str_deviceid), forKey: "deviceId")
            print(parameterDictionary)
            
            let methodName = "/updateDetail"
            
            getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["sucess"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if success == "1"{
                        let data = DataManager.getVal(responseData?["data"]) as? String ?? ""
                        
                        if let user = DataManager.getVal(responseData?["user"]) as? [String : Any]{
                        let _id = DataManager.getVal(user["_id"]) as? String ?? ""
                        let defaults = UserDefaults.standard
                        defaults.setValue(_id, forKey: "iduser")
                        defaults.synchronize()
                        }
                        
                        Config().AppUserDefaults.set(data, forKey: "token")
                        
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == EmailTxtField{
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

}
