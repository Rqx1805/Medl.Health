
//
//  EnterYourAddress_iPad.swift
//  Medl
//
//  Created by mac-15 on 24/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
class EnterYourAddress_iPad: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var PickUpTimeCollectionView: UICollectionView!
    @IBOutlet weak var Segment: UISegmentedControl!

    //MARK:-DeliveryInfoView
    @IBOutlet weak var DeliveryInfoView: UIView!
    
    fileprivate var selectedCell = Int()
    
    @IBOutlet weak var AddressTxtField: MyTextField!
    @IBOutlet weak var AddressLine1TxtField: UITextField!
    @IBOutlet weak var AddressLine2TxtField: UITextField!
    @IBOutlet weak var TelephoneNumberTxtField: UITextField!
    @IBOutlet weak var BackUpTelephoneNumberTxtField: UITextField!
    
    
    var AddressListArray = [Any]()
    var pickUpTimeArray = [String]()
    var SelectedTime = String()
    
    var SubCategoriesArray: [String] = []
    var idarray:NSArray!
    var pricearray:NSArray!
    var DetailButtonFlag = Bool()
    var tabType = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Segment.selectedSegmentIndex = 0
        self.pickUpTimeArray = ["09:00 AM - 10:00 AM","10:00 AM - 11:00 AM","12:00 AM - 01:00 AM","02:00 AM - 03:00 AM"]
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        let LiberaryLayOut = UICollectionViewFlowLayout()
        LiberaryLayOut.itemSize = CGSize(width: PickUpTimeCollectionView.frame.size.width/1.1, height: 50)
        LiberaryLayOut.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        LiberaryLayOut.minimumInteritemSpacing = 10
        LiberaryLayOut.minimumLineSpacing = 10
        LiberaryLayOut.scrollDirection = .vertical
        
        let LayOutClassNearBy = UINib(nibName: "PickUpTimeCollectionCell", bundle: nil)
        self.PickUpTimeCollectionView.register(LayOutClassNearBy, forCellWithReuseIdentifier: "PickUpTimeCollectionCell")
        self.PickUpTimeCollectionView.collectionViewLayout = LiberaryLayOut
        
        self.AddressList_API()
        
    }
    func AddressList_API(){
        
        self.showHud()
        
        let parameterDictionary = NSMutableDictionary()
        print(parameterDictionary)
        
        let methodName = "/listAddress"
        
        getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
            if error == nil{
                let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                
                if success == "1"{
                    self.AddressListArray = DataManager.getVal(responseData?.object(forKey: "data")) as? [Any] ?? []
                    
                    let categories_list =  DataManager.getVal(responseData?.object(forKey: "data"))  as! [NSDictionary]
                    
                    for categoriesData in categories_list {
                        self.SubCategoriesArray.append(categoriesData.object(forKey: "street") as? String ?? "")
                    }
                }else{
                    Config().error(message: message)
                }
            }
            self.clearHud()
        }
    }
    
    @IBAction func NextButtonAction(_ sender: MyButton) {
        
        if ValidationClass().Validate_Address_iPad_Form(self){
            
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(DataManager.getVal(""), forKey: "street")
            parameterDictionary.setValue(DataManager.getVal(self.AddressLine1TxtField.text!), forKey: "add")
            parameterDictionary.setValue(DataManager.getVal(self.AddressLine2TxtField.text!), forKey: "add2")
            parameterDictionary.setValue(DataManager.getVal(self.TelephoneNumberTxtField.text!), forKey: "phoneNumber")
            parameterDictionary.setValue(DataManager.getVal(self.BackUpTelephoneNumberTxtField.text!), forKey: "extNumber")
            parameterDictionary.setValue(DataManager.getVal(self.SelectedTime), forKey: "pickUpTime")
            parameterDictionary.setValue(DataManager.getVal(""), forKey: "area")

            print(parameterDictionary)
            
            let methodName = "/deliveryDetails"
            
            getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if success == "1"{
                        self.AddressTxtField.text = ""
                        self.AddressLine1TxtField.text = ""
                        self.AddressLine2TxtField.text = ""
                        self.TelephoneNumberTxtField.text = ""
                        self.BackUpTelephoneNumberTxtField.text = ""
                        
                        Config().success(message: message)
                        let vc = PaymentInfoVC_Ipad(nibName: "PaymentInfoVC_Ipad", bundle: nil)
                        self.onlyPushViewController(vc)
                    }else{
                        Config().error(message: message)
                    }
                }
                self.clearHud()
            }
        }
    }
    
    //MARK:- CollectionView Delegete
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pickUpTimeArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickUpTimeCollectionCell", for: indexPath) as! PickUpTimeCollectionCell
        cell.layer.cornerRadius = 6
        
        cell.tag = indexPath.row
        
        if selectedCell == indexPath.row{
            cell.backgroundColor = Config().AppNavBlueColor
            cell.TitleLbl.textColor = UIColor.white
            cell.layer.cornerRadius = 4
            cell.layer.borderColor = Config().AppNavBlueColor.cgColor
            cell.layer.borderWidth = 1
        }else{
            cell.backgroundColor = UIColor.white
            cell.TitleLbl.textColor = Config().AppNavBlueColor
            cell.layer.cornerRadius = 4
            cell.layer.borderColor = Config().AppNavBlueColor.cgColor
            cell.layer.borderWidth = 1
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCell = indexPath.row
        self.SelectedTime =  self.pickUpTimeArray[indexPath.row]
        self.PickUpTimeCollectionView.reloadData()
        
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
    @IBAction func SupportButtonAction(_ sender: UIButton) {
        let vc = SupportVC_iPad(nibName: "SupportVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
        
    }
    @IBAction func NotificationButtonAction(_ sender: UIButton) {
        let vc = NotificationVC_iPad(nibName: "NotificationVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
    }
    
    @IBAction func EditAccountButtonAction(_ sender: UIButton) {
        let vc = EditAccount_iPad(nibName: "EditAccount_iPad", bundle: nil)
        self.onlyPushViewController(vc)
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.AddressTxtField{
            self.view.endEditing(true)
            
            if self.SubCategoriesArray.count != 0 {
                StringPickerPopover(title: "Address", choices: self.SubCategoriesArray)
                    .setSelectedRow(0)
                    
                    .setDoneButton(title: "Done", color: Config().AppWhiteColor, action: { (popover, selectedRow, selectedString) in
                        
                        print("done row \(selectedRow) \(selectedString)")
                        self.AddressTxtField.text = selectedString
                        self.AddressTxtField.resignFirstResponder()
                        
                    })
                    
                    .setCancelButton(title: "Cancel", color: Config().AppWhiteColor, action: { (_, _, _) in
                        print("Cancel")
                    })
                    .appear(originView: self.AddressTxtField, baseViewController: self)
            }else{
                self.view.makeToast(message: "No level found")
            }
            return false
        }else{
            return true
        }
        
    }
    
}
