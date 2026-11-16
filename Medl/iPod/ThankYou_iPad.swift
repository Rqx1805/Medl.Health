//
//  ThankYou_iPad.swift
//  Medl
//
//  Created by mac-15 on 24/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class ThankYou_iPad: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBAction func CloseButtonAction(_ sender: MyButton) {
        let vc = DashBoard_iPad(nibName: "DashBoard_iPad", bundle: nil)
        self.RootViewControllerWithOutNav(vc)
        
    }
    
}
