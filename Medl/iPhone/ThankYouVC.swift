//
//  ThankYouVC.swift
//  Medl
//
//  Created by mac-15 on 24/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class ThankYouVC: UIViewController {

    @IBOutlet weak var CloseButton: MyButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
    }


    @IBAction func CloseButtonAction(_ sender: MyButton) {
        let vc = DashBoard(nibName: "DashBoard", bundle: nil)
        self.RootViewControllerWithNav(vc)
    }
    

}
