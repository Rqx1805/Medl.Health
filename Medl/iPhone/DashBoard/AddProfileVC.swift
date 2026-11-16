//
//  AddProfileVC.swift
//  Medl
//
//  Created by mac-15 on 24/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class AddProfileVC: BackBaseProfile,UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet weak var Telephone_NumberTxtField: FloatLabelTextField!
    @IBOutlet weak var AlternateNumberTxtField: FloatLabelTextField!
    @IBOutlet weak var Preferred_AddressTxtField: MyTextField!
    
    var deliveryAddress_Array = [Any]()
    var defaultAddress_Array = [Any]()
    var DefultAddress_Status = String()
    @IBOutlet var AddressHiddenView: UIView!
    @IBOutlet weak var AddressTblView: UITableView!
    @IBOutlet weak var EmailTxtField: FloatLabelTextField!
    
    
    //Edit Address
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet var EditHiddenView: UIView!
    @IBOutlet weak var AddressContactNumberTxtField: FloatLabelTextField!
    @IBOutlet weak var ExtNumberTxtField: FloatLabelTextField!
    @IBOutlet weak var EditStreetAddressTxtField: FloatLabelTextField!
    @IBOutlet weak var EditBuildingAddressTxtField: FloatLabelTextField!
    @IBOutlet weak var EditAreaTxtFielld: MyTextField!
    
    @IBOutlet weak var addleftConst: NSLayoutConstraint!
    @IBOutlet weak var addressHeightCons: NSLayoutConstraint!
    @IBOutlet weak var editbtn: MyButton!
    
    @IBOutlet weak var perLbl: UILabel!
    @IBOutlet weak var perlblheightCons: NSLayoutConstraint!
    
    @IBOutlet weak var addwithCons: NSLayoutConstraint!
    
   
    @IBOutlet weak var addAddressBtn: MyButton!
    
    @IBOutlet weak var addAddressTopConst: NSLayoutConstraint!
    var _id = String()
    var userId = String()
    var addressId = String()
    var SelectValue  = -1
    
    var Area_Name_Array:[String] = []
    var lastSelectedIndexPath = NSIndexPath(row: -1, section: 0)
    var select_type_array = [String]()
    var ns = NSMutableArray()
    var newid:String!
    
    @IBOutlet weak var addBtn: MyButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.ProfileData_API()
        self.defaultAddressAPI()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
       
        if select_type_array.count == 0 {
            
        }else {
            select_type_array = defaults.array(forKey: "Array") as! [String]
        }
       
        
        self.EditImage = "SettingGreen"
        
        let nibClass = UINib(nibName: "AddressTableCell", bundle: nil)
        self.AddressTblView.register(nibClass, forCellReuseIdentifier: "AddressTableCell")
        self.AddressTblView.estimatedRowHeight = 60
        self.AddressTblView.rowHeight = UITableView.automaticDimension
        self.AddressTblView.dataSource = self
        self.AddressTblView.delegate = self
        self.AddressTblView.tableFooterView = UIView()
        self.AddressTblView.sectionHeaderHeight = 0
        self.AddressTblView.separatorStyle = .none
        
        self.Preferred_AddressTxtField.layer.cornerRadius = 4
        self.Preferred_AddressTxtField.BorderWidth = 2
        self.AddressHiddenView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 65 )
        self.EditHiddenView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

    }
   
    @IBAction func addAddressBtnActionNew(_ sender: Any) {
        self.TitleLbl.text = "Add New Address"
        self.AddressContactNumberTxtField.text = ""
        self.ExtNumberTxtField.text = ""
        self.EditStreetAddressTxtField.text = ""
        self.EditAreaTxtFielld.text = ("  \("")")
        self.EditBuildingAddressTxtField.text = ""
        
        self.showAnimate(YourHiddenView: self.EditHiddenView, ishidden: false)
    }
    func ProfileData_API(){
            
            self.showHud()
            
            let parameterDictionary = NSMutableDictionary()
            print(parameterDictionary)
            
            let methodName = "/patientDetails"
            
            getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if success == "1"{
                        
                        if let dataDict = DataManager.getVal(responseData?.object(forKey: "data")) as? NSDictionary{
                            self.userId = DataManager.getVal(dataDict["_id"]) as? String ?? ""
                            self.deliveryAddress_Array = DataManager.getVal(dataDict["deliveryAddress"]) as? [Any] ?? []
                            
                            if self.deliveryAddress_Array.count == 0 {
                                self.Preferred_AddressTxtField.isHidden = true
                                self.addressHeightCons.constant = 0
                                self.editbtn.isHidden = true
                                self.addBtn.isHidden = true
                                self.addAddressBtn.isHidden = false
                                self.perLbl.isHidden = true
                                self.perlblheightCons.constant = 0
                                self.addAddressTopConst.constant = -25
                                self.DefultAddress_Status = "1"
                                
                            }else {
                                self.Preferred_AddressTxtField.isHidden = false
                                self.addressHeightCons.constant = 50
                                self.editbtn.isHidden = false
                                self.perLbl.isHidden = false
                                self.addBtn.isHidden = false
                                self.addAddressBtn.isHidden = true
                                self.perlblheightCons.constant = 20
                                self.addAddressTopConst.constant = 3.33
                                self.DefultAddress_Status = "0"
                            }
                            
                            let mobile = DataManager.getVal(dataDict["mobile"]) as? String ?? ""
                            let mobile1 = mobile.replacingOccurrences(of: "1868", with: "")
                            let email = DataManager.getVal(dataDict["email"]) as? String ?? ""
                            let altNumber = DataManager.getVal(dataDict["altNumber"]) as? String ?? ""
                            let altNumber1 = altNumber.replacingOccurrences(of: "1868", with: "")
                           // self.addressId = (self.deliveryAddress_Array[0] as! NSDictionary).value(forKey: "_id") as? String ?? ""
                            for i in 0..<self.deliveryAddress_Array.count {
                                var dict = NSDictionary()
                                dict = self.deliveryAddress_Array[i] as! NSDictionary
                               
                                self.DefultAddress_Status = DataManager.getVal(dict["status"]) as? String ?? ""
                                print(self.DefultAddress_Status)
                                if self.DefultAddress_Status == "1" {
                                    self.addressId = dict.value(forKey: "street") as! String
                                    print(self.addressId)
                                  //  self.Preferred_AddressTxtField.text = ("  \(self.addressId)")
                                    self.newid = dict.value(forKey: "_id") as? String
                                    let extNumber = dict.value(forKey: "extNumber") as! String
                                    let extNumber1 = extNumber.replacingOccurrences(of: "1868", with: "")
                                    let phoneNumber = dict.value(forKey: "phoneNumber") as! String
                                    let phoneNumber1 = phoneNumber.replacingOccurrences(of: "1868", with: "")
                                    let add = dict.value(forKey: "add") as! String
                                    let area = dict.value(forKey: "area") as! String
                                    if add == ""
                                    {
                                       self.Preferred_AddressTxtField.text = " " + self.addressId + ", " + area
                                    }else {
                                        self.Preferred_AddressTxtField.text = " " + self.addressId + ", " + add + ", " + area
                                    }
                                    
                                    self.EditStreetAddressTxtField.text = self.addressId
                                    self.EditBuildingAddressTxtField.text = add
                                    self.EditAreaTxtFielld.text = ("  \(area)")
                                    self.AddressContactNumberTxtField.text = phoneNumber1
                                    self.ExtNumberTxtField.text = extNumber1
                                    break
                                }else {
                                    
                                }
                            }
                            
    //                        let status = (self.deliveryAddress_Array[0] as! NSDictionary).value(forKey: "status") as? String ?? ""
                            self.AlternateNumberTxtField.text = altNumber1
                            self.Telephone_NumberTxtField.text = mobile1
                            self.EmailTxtField.text = email
                            
                           // self.defaultAddressAPI()
                        }
                        self.AddressTblView.reloadData()
                    }else{
                        Config().error(message: message)
                    }
                }
                self.clearHud()
            }
        }
    
    //Edit Address
    @IBAction func EditCancelButtonAction(_ sender: MyButton) {
        self.removeAnimate(YourHiddenView: self.EditHiddenView, ishidden: true)
    }
    @IBAction func Edit_Save_AddressButtonAction(_ sender: MyButton) {
        
        if ValidationClass().Validate_Edit_Address_Form(self){
            if self.TitleLbl.text == "Edit Address"{
                self.showHud()
                
                let parameterDictionary = NSMutableDictionary()
                var str:String!
                    str = self.AddressContactNumberTxtField.text!
                    var newstr:String!
                    newstr = "1868"
                    var newstr2:String!
                    newstr2 = newstr + str
                    print(newstr2!)
                
                  var str1:String!
                  str1 = self.ExtNumberTxtField.text!
                  var newstr3:String!
                  newstr3 = "1868"
                  var newstr5:String!
                  newstr5 = newstr3 + str1
                  print(newstr5!)
                parameterDictionary.setValue(DataManager.getVal(self.EditStreetAddressTxtField.text!), forKey: "street")
                parameterDictionary.setValue(DataManager.getVal(self.EditBuildingAddressTxtField.text!), forKey: "add")
                parameterDictionary.setValue(DataManager.getVal(self.EditAreaTxtFielld.text!), forKey: "area")
                parameterDictionary.setValue(DataManager.getVal(newstr2), forKey: "phoneNumber")
                parameterDictionary.setValue(DataManager.getVal(newstr5), forKey: "extNumber")
                parameterDictionary.setValue(DataManager.getVal(""), forKey: "pickUpTime")
                parameterDictionary.setValue(DataManager.getVal(self.newid), forKey: "id")
                parameterDictionary.setValue(DataManager.getVal(self.DefultAddress_Status), forKey: "status")
                print(parameterDictionary)
                
                let methodName = "/editAddress"
                
                getallApiResultwithPostTokenMethodWithStatus(parameter: parameterDictionary, Methodname: methodName, completionHandler:{ (responseData, error,status) in
                    if error == nil{
                        let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                        let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                        
                        if success == "1"{
                            self.removeAnimate(YourHiddenView: self.EditHiddenView, ishidden: true)
                            self.ProfileData_API()
                             self.defaultAddressAPI()
                            Config().success(message: message)
                        }else{
                            Config().error(message: message)
                        }
                    }
                    self.clearHud()
                })
            }else{
                self.showHud()
                let parameterDictionary = NSMutableDictionary()
                  var str:String!
                                 str = self.AddressContactNumberTxtField.text!
                                 var newstr:String!
                                 newstr = "1868"
                                 var newstr2:String!
                                 newstr2 = newstr + str
                                 print(newstr2!)
                             
                               var str1:String!
                               str1 = self.ExtNumberTxtField.text!
                               var newstr3:String!
                               newstr3 = "1868"
                               var newstr5:String!
                               newstr5 = newstr3 + str1
                               print(newstr5!)
                parameterDictionary.setValue(DataManager.getVal(self.EditStreetAddressTxtField.text!), forKey: "street")
                parameterDictionary.setValue(DataManager.getVal(self.EditBuildingAddressTxtField.text!), forKey: "add")
                parameterDictionary.setValue(DataManager.getVal(newstr2), forKey: "phoneNumber")
                parameterDictionary.setValue(DataManager.getVal(newstr5), forKey: "extNumber")
                parameterDictionary.setValue(DataManager.getVal(""), forKey: "pickUpTime")
                parameterDictionary.setValue(DataManager.getVal(self.EditAreaTxtFielld.text!), forKey: "area")
                parameterDictionary.setValue(DataManager.getVal(self.DefultAddress_Status), forKey: "status")
                print(parameterDictionary)
                
                let methodName = "/deliveryDetails"
                
                getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
                    if error == nil{
                        let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                        let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                        
                        if success == "1"{
                            self.EditStreetAddressTxtField.text = ""
                            self.EditBuildingAddressTxtField.text = ""
                            self.AddressContactNumberTxtField.text = ""
                            self.ExtNumberTxtField.text = ""
                            self.EditAreaTxtFielld.text = ""
                            self.ProfileData_API()
                            self.defaultAddressAPI()
                            self.removeAnimate(YourHiddenView: self.EditHiddenView, ishidden: true)
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
    
    @IBAction func DoneButtonAction(_ sender: UIButton) {
        self.removeAnimate(YourHiddenView: self.AddressHiddenView, ishidden: true)
    }
    
    @IBAction func btn_changePasswordAction(_ sender: MyButton) {
        let vc = ChangePasswordVC(nibName: "ChangePasswordVC", bundle: nil)
        self.onlyPushViewController(vc)
    }
    @IBAction func EditAddressButtonAction(_ sender: MyButton) {
        
        if self.Preferred_AddressTxtField.text == "Preferred address"{
            Config().error(message: "Please select preferred address.")
        }else{
            self.TitleLbl.text = "Edit Address"
            self.showAnimate(YourHiddenView: self.EditHiddenView, ishidden: false)
            self.ProfileData_API()
            
        }
    }
    @IBAction func Add_AddressButtonAction(_ sender: MyButton) {
        self.TitleLbl.text = "Add New Address"
        self.AddressContactNumberTxtField.text = ""
        self.ExtNumberTxtField.text = ""
        self.EditStreetAddressTxtField.text = ""
        self.EditAreaTxtFielld.text = ("  \("")")
        self.EditBuildingAddressTxtField.text = ""
        
        self.showAnimate(YourHiddenView: self.EditHiddenView, ishidden: false)
    }
    
    
    func defaultAddressAPI(){

        self.showHud()
        let parameterDictionary = NSMutableDictionary()

        parameterDictionary.setValue(DataManager.getVal(newid), forKey: "addressId")
        parameterDictionary.setValue(DataManager.getVal(userId), forKey: "id")
        print(parameterDictionary)

        let methodName = "/setDefaultAddress"

        getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
            if error == nil{
                let success = DataManager.getVal(responseData?["sucess"]) as? String ?? ""
//                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""

                if success == "1"{

                    let dataDict = DataManager.getVal(responseData?.object(forKey: "data")) as? NSDictionary
                    self.deliveryAddress_Array = DataManager.getVal(dataDict!["deliveryAddress"]) as? [Any] ?? []
                    if self.deliveryAddress_Array.count == 0 {
                        self.DefultAddress_Status = "1"
                    }else {
                         self.DefultAddress_Status = "0"
                    }
                    
                    for i in 0..<self.deliveryAddress_Array.count {
                        var dict = NSDictionary()
                        dict = self.deliveryAddress_Array[i] as! NSDictionary
                        
                        self.DefultAddress_Status = DataManager.getVal(dict["status"]) as? String ?? ""
                        print(self.DefultAddress_Status)
                        if self.DefultAddress_Status == "1" {
                            self.addressId = dict.value(forKey: "street") as! String
                            
                            
                            let extNumber = dict.value(forKey: "extNumber") as! String
                            let phoneNumber = dict.value(forKey: "phoneNumber") as! String
                            let add = dict.value(forKey: "add") as! String
                            let area = dict.value(forKey: "area") as! String
                            if add == "" {
                                self.Preferred_AddressTxtField.text = " " + self.addressId  + ", " + area
                            }else {
                                self.Preferred_AddressTxtField.text = " " + self.addressId + ", " + add + ", " + area
                            }
                           
                                //("  \(self.addressId)")
                            self.EditStreetAddressTxtField.text = self.addressId
                            self.EditBuildingAddressTxtField.text = add
                            self.EditAreaTxtFielld.text = ("  \(area)")
                            self.AddressContactNumberTxtField.text = phoneNumber
                            self.ExtNumberTxtField.text = extNumber
                        }else {

                        }
                    }

                }else{
//                    Config().error(message: message)
                }
            }
            self.clearHud()
        }
    }
    
    @IBAction func Save_ButtonAction(_ sender: MyButton) {
        if ValidationClass().Validate_editProfile_Form(self){
            
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
                var str:String!
                str = self.Telephone_NumberTxtField.text!
                var newstr:String!
                newstr = "1868"
                var newstr2:String!
                newstr2 = newstr + str
                print(newstr2!)
            
              var str1:String!
              str1 = self.AlternateNumberTxtField.text!
              var newstr3:String!
              newstr3 = "1868"
              var newstr5:String!
              newstr5 = newstr3 + str1
              print(newstr5!)
            
            parameterDictionary.setValue(DataManager.getVal(newstr2), forKey: "mobile")
            parameterDictionary.setValue(DataManager.getVal(newstr5), forKey: "altNumber")
            print(parameterDictionary)
            
            let methodName = "/updateProfile"
            
            getallApiResultwithPostTokenMethodWithStatus(parameter: parameterDictionary, Methodname: methodName, completionHandler:{ (responseData, error,status) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    
                    if success == "1"{
                        Config().success(message: message)
                    }else{
                        Config().error(message: message)
                    }
                }
                self.clearHud()
            })
        }
    }
    @IBAction func Cancel_ButtonAction(_ sender: MyButton) {
        self.navigationController?.popViewController(animated: true )
    }
    
    @objc func CheckButtonAction(_ sender: UIButton){
        
           let indexPath = sender.tag
           let dict = DataManager.getVal(self.deliveryAddress_Array[indexPath]) as! NSDictionary
           let status = DataManager.getVal(dict["status"]) as? String ?? ""
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliveryAddress_Array.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableCell", for: indexPath) as! AddressTableCell
        let dict = DataManager.getVal(self.deliveryAddress_Array[indexPath.row]) as! NSDictionary
        let id = DataManager.getVal(dict["_id"]) as? String ?? ""
        let street = DataManager.getVal(dict["street"]) as? String ?? ""
        let add = DataManager.getVal(dict["add"]) as? String ?? ""
        let area = DataManager.getVal(dict["area"]) as? String ?? ""
        let phoneNumber = DataManager.getVal(dict["phoneNumber"]) as? String ?? ""
       
        var status:Int!
        status = dict.value(forKey: "status") as? Int
        if status == 1 {
            cell.checkBtn.setImage(UIImage(named: "GreenRadioButtonActive"), for: .normal)
        }else {
             cell.checkBtn.setImage(UIImage(named: "GREEN_UNCHECK"), for: .normal)
        }
        if add == "" {
           cell.AddressLbl.text = street + ", " + area
        }else {
            cell.AddressLbl.text = street + ", " + add + ", " + area
        }
        
        cell.phoneNumberLbl.text = "Phone: \(phoneNumber)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = DataManager.getVal(self.deliveryAddress_Array[indexPath.row]) as! NSDictionary
        let street = DataManager.getVal(dict["street"]) as? String ?? ""
        let st = DataManager.getVal(dict["street"])
        let add = DataManager.getVal(dict["add"]) as? String ?? ""
        let extNumber = DataManager.getVal(dict["extNumber"]) as? String ?? ""
        let phoneNumber = DataManager.getVal(dict["phoneNumber"]) as? String ?? ""
        let area = DataManager.getVal(dict["area"]) as? String ?? ""
        
        self.newid = DataManager.getVal(dict["_id"]) as? String ?? ""
        self.AddressContactNumberTxtField.text = phoneNumber
        self.ExtNumberTxtField.text = extNumber
        self.EditStreetAddressTxtField.text = street
        self.EditAreaTxtFielld.text = ("  \(area)")
        self.EditBuildingAddressTxtField.text = add
        
        self.Preferred_AddressTxtField.text = street + ", " + add + ", " + area
            //("  \(street)")
        defaultAddressAPI()
        self.removeAnimate(YourHiddenView: self.AddressHiddenView, ishidden: true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.Preferred_AddressTxtField{
            self.view.endEditing(true)
            ProfileData_API()
            if self.deliveryAddress_Array.count == 0{
                Config().error(message: "No Address Found.")
            }else{
                self.showAnimate(YourHiddenView: self.AddressHiddenView, ishidden: false)
            }
            return false
            
        }else if textField == self.EditAreaTxtFielld{
            self.view.endEditing(true)
            self.areaList_API()
            return false
        }else{
            return true
        }
    }
    
    func showAnimate(YourHiddenView: UIView,ishidden: Bool){
        self.view.addSubview(YourHiddenView)
        YourHiddenView.isHidden = ishidden
        YourHiddenView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        YourHiddenView.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            YourHiddenView.alpha = 1.0
            YourHiddenView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate(YourHiddenView: UIView,ishidden: Bool){
        UIView.animate(withDuration: 0.25, animations: {
            YourHiddenView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            YourHiddenView.alpha = 0.0
            
        }, completion: {(finished : Bool) in
            if(finished)
            {
                YourHiddenView.isHidden = ishidden
                self.willMove(toParent: nil)
                YourHiddenView.removeFromSuperview()
                //self.removeFromParent()
            }
        })
    }
    func areaList_API(){
        self.showHud()
        
        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(DataManager.getVal("North West"), forKey: "zone")
        print(parameterDictionary)
        
        let methodName = "/areaList"
        
        getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
            if error == nil{
                let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                
                if success == "1"{
                    
                    self.Area_Name_Array = []
                    
                    let data =  DataManager.getVal(responseData?.object(forKey: "data")) as? [Any] ?? []
                    if let dict = DataManager.getVal(data[0]) as? NSDictionary{
                        let city =  DataManager.getVal(dict.object(forKey: "city")) as? [String] ?? []
                        
                        if city.count != 0 {
                            DPPickerManager.shared.showPicker(title: "Area list", selected: "", strings: city) { (value, index, cancel) in
                                if !cancel {
                                    self.EditAreaTxtFielld.text = ("  \(value ?? "")")
                                    print(value!)
                                }
                            }
                        }else{
                            Config().error(message: "No data found.")
                        }
                    }
                }else{
                    Config().error(message: message)
                }
                self.clearHud()
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.AddressContactNumberTxtField{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= 15
            
        }else if textField == self.ExtNumberTxtField{
           
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
           return newString.length <= 15

        }else if textField == self.Telephone_NumberTxtField{
                  
             let currentString: NSString = textField.text! as NSString
             let newString: NSString =
             currentString.replacingCharacters(in: range, with: string) as NSString
             return newString.length <= 15

                }
            else if textField == self.AlternateNumberTxtField{
                        return true
                        let currentString: NSString = textField.text! as NSString
                        let newString: NSString =
                            currentString.replacingCharacters(in: range, with: string) as NSString
                        return newString.length <= 15

                    }
        else if textField == self.EditStreetAddressTxtField{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= 255

        }else if textField == self.EditBuildingAddressTxtField{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= 255
        }else{
            return true
        }
    }
}
