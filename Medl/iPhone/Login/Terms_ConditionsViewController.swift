//
//  Terms&ConditionsViewController.swift
//  Medl
//
//  Created by Ashish Soni on 18/08/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class Terms_ConditionsViewController: UIViewController {

    @IBOutlet weak var webviewvc: UIWebView!
    
    
    
    //MARK:- Login WebService
        @objc func MedlTermsAction(_ notification: Notification) {
            
            let status = (notification.userInfo?["success"] as? Int)!
            
            
            DispatchQueue.main.async() {
                
                if status == 0{
                    NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "GetTermsConsition"), object: nil)
                }
                else {
                    var dict = NSDictionary()
                    dict = (notification.userInfo?["data"] as? NSDictionary)!
                    var htmltext:String!
                    htmltext = dict.value(forKey: "html") as? String
                    self.webviewvc.loadHTMLString(htmltext, baseURL: nil)
                    
                    NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "GetTermsConsition"), object: nil)
                }
            }
        }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Parsing().GetTermsConsition()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "GetTermsConsition"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.MedlTermsAction), name: NSNotification.Name(rawValue: "GetTermsConsition"), object: nil)
        // Do any additional setup after loading the view.
    }

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
