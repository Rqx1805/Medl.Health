//
//  LoginNew.swift
//  Medl
//
//  Created by MAC-27 on 09/06/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class LoginNew: UIViewController {

        @IBOutlet weak var firstUser: MyButton!
        @IBOutlet weak var loginUser: MyButton!
        
        var loginVCID: String!
        let isBlurUI = true
        var defaults:UserDefaults!
        var str_deviceid:String!
        
        override func viewDidLoad() {
            super.viewDidLoad()

            defaults = UserDefaults.standard
            str_deviceid = defaults.value(forKey:"Devicetoken") as? String
            self.navigationController?.isNavigationBarHidden = true
            
    //        self.loginVCID = self.isBlurUI ? "BlurPasswordLoginViewController" : "PasswordLoginViewController"
        }


        @IBAction func firstUser_action(_ sender: Any) {
            
            let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
            self.onlyPushViewController(vc)
            
            
        }
        
        @IBAction func loginUser_Action(_ sender: Any) {
            
            let vc = LoginVC(nibName: "LoginVC", bundle: nil)
            self.onlyPushViewController(vc)
            
        }

}
