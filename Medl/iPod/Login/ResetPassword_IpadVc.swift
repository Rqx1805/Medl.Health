//
//  ResetPassword_IpadVc.swift
//  Medl
//
//  Created by Ashish Soni on 16/07/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class ResetPassword_IpadVc: UIViewController {

    @IBOutlet weak var enterPassTxt: UITextField!
    @IBOutlet weak var reEnterPassTxt: UITextField!
     var data_str = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveBtnActiom(_ sender: Any) {
        if ValidationClass().Validate_ResetPasswordForm1(self){
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(DataManager.getVal(self.enterPassTxt.text!), forKey: "password")
            parameterDictionary.setValue(DataManager.getVal(self.data_str), forKey: "token")
             print(parameterDictionary)
            
            let methodName = "/resetPassword"
            
            getAllApiResults(parameter: parameterDictionary, MethodName: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                     
                    if success == "1"{
                        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
