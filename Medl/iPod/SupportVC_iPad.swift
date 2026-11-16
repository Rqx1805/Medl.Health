//
//  SupportVC_iPad.swift
//  Medl
//
//  Created by mac-15 on 26/11/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit
import MessageUI
import CRNotifications
class SupportVC_iPad: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var EmailTxtField: UITextField!
    @IBOutlet weak var ReviewTxtField: UITextView!
    @IBOutlet weak var HeadingTxtField: UITextField!
    
    var defaults:UserDefaults!
    var status:Int!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var secondNumber: UILabel!
    
    var myPickerView : UIPickerView!
    var pickerData = ["I need help with the medl app","I need help with my order","I have questions about my prescription"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HeadingTxtField.delegate = self
        
        self.ReviewTxtField.layer.borderWidth = 1
        self.ReviewTxtField.layer.cornerRadius = 3
        self.EmailTxtField.layer.cornerRadius = 3
        self.EmailTxtField.layer.masksToBounds = true
        self.HeadingTxtField.layer.cornerRadius = 3
        self.HeadingTxtField.layer.masksToBounds = true
        
        self.EmailTxtField.text = (DataManager.getVal(Config().AppUserDefaults.value(forKey: "email")) as! String)
        self.EmailTxtField.isEnabled = false
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        self.EmailTxtField.attributedPlaceholder = NSAttributedString(string: "Work email",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.HeadingTxtField.attributedPlaceholder = NSAttributedString(string: "What do you need support with?",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        let tap = UITapGestureRecognizer(target: self, action: #selector(SupportVC_iPad.emailURL))
        email.isUserInteractionEnabled = true
        email.addGestureRecognizer(tap)
        let string = "hello@medl.com"
        let attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        self.email.attributedText = NSAttributedString(string: string, attributes: attributes)
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(SupportVC_iPad.callURL))
        phoneNumber.isUserInteractionEnabled = true
        phoneNumber.addGestureRecognizer(tapped)
        let call = "1(868) 610-6335"
        let attribute = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        self.phoneNumber.attributedText = NSAttributedString(string: call, attributes: attribute)
        
        
        let tapped1 = UITapGestureRecognizer(target: self, action: #selector(SupportVC_iPad.callURL1))
        secondNumber.isUserInteractionEnabled = true
        secondNumber.addGestureRecognizer(tapped1)
        let call1 = "1(868) 609-6335"
        let attribute1 = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        self.secondNumber.attributedText = NSAttributedString(string: call1, attributes: attribute1)
        
    }
    func error(message: String){
        CRNotifications.showNotification(type: CRNotifications.error, title: "Error", message: message, dismissDelay: 3)
    }
    
    @objc func emailURL(sender: UITapGestureRecognizer) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients(["hello@medl.com"])
            mailComposer.setSubject("Medl Support")
            mailComposer.setMessageBody("Please have a look medl app.", isHTML: false)
            self.present(mailComposer, animated: true)
        }else {
            self.error(message: "Please install the mail.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure")
        default:
            break
        }
    }
    
    @objc func callURL(){
        print("tap working")
        UIApplication.shared.open(NSURL(string: "tel://\(+18686106335)")! as URL)
    }
    
    @objc func callURL1(){
        print("tap working")
        UIApplication.shared.open(NSURL(string: "tel://\(+18686096335)")! as URL)
    }
    
    func pickUp(_ textField : UITextField){
        
    self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
    self.myPickerView.delegate = self
    self.myPickerView.dataSource = self
    self.myPickerView.backgroundColor = UIColor.white
    textField.inputView = self.myPickerView
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SupportVC.doneClick))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(SupportVC.cancelClick))
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    textField.inputAccessoryView = toolBar
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.HeadingTxtField.text = pickerData[row]
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == HeadingTxtField{
           self.pickUp(HeadingTxtField)
        }
    }
    @objc func doneClick() {
    HeadingTxtField.resignFirstResponder()
    }
    @objc func cancelClick() {
    HeadingTxtField.resignFirstResponder()
    }
    
    
    @IBAction func SubmitButtonAction(_ sender: MyButton) {
        
        if self.HeadingTxtField.text == ""{
            Config().info(message: "Please select your query type.")
        }
        else if self.ReviewTxtField.text == ""{
            Config().info(message: "Please enter your query description.")
        }
        else{
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(DataManager.getVal(self.ReviewTxtField.text!), forKey: "query")
            parameterDictionary.setValue(DataManager.getVal(self.HeadingTxtField.text!), forKey: "queryType")
            print(parameterDictionary)
            
            let methodName = "/support"
            
            getallApiResultwithPostTokenMethodWithStatus(parameter: parameterDictionary, Methodname: methodName, completionHandler:{ (responseData, error,status) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if status == 200{
                        Config().success(message: message)
                        self.ReviewTxtField.text = ""
                        self.HeadingTxtField.text = ""
                    }else{
                        Config().error(message: message)
                    }
                }
                self.clearHud()
            })
        }
    }
    //MARK:- Navigation Bar Button Action
    @IBAction func BackButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func LogOutButtonAction(_ sender: UIButton) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("Yes", backgroundColor: Config().AppNavBlueColor){
            Config().AppUserDefaults.set("no", forKey: "login")
            
            let vc = LoginVC_iPod(nibName: "LoginVC_iPod", bundle: nil)
            self.RootViewControllerWithNav(vc)
        }
        alert.addButton("No", backgroundColor: Config().AppNavBlueColor){
            print("No")
        }
        alert.showEdit("Logout", subTitle: "Are you sure you want to logout?")
    }
    @IBAction func NotificationButtonAction(_ sender: UIButton) {
        let vc = NotificationVC_iPad(nibName: "NotificationVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
    }
    
    @IBAction func SupportButtonAction(_ sender: UIButton) {
        
    }
    @IBAction func EditAccountButtonAction(_ sender: UIButton) {
        let vc = EditAccount_iPad(nibName: "EditAccount_iPad", bundle: nil)
        self.onlyPushViewController(vc)
        
    }
    
}
