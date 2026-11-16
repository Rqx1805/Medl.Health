//
//  ResetPasswordVC.swift
//  Medl
//
//  Created by mac-15 on 04/02/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit
import MKToolTip
class ResetPasswordVC: UIViewController  {

    @IBOutlet weak var NewPasswordTxtField: FloatLabelTextField!
    @IBOutlet weak var ReEnterPasswordTxtField: FloatLabelTextField!
    
    var data_str = String()
    @IBOutlet weak var buttonB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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


    @IBAction func btnReset(_ sender: UIButton) {
        if ValidationClass().Validate_ResetPasswordForm(self){
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(DataManager.getVal(self.NewPasswordTxtField.text!), forKey: "password")
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
