//
//  EnterAddress_IpadVC.swift
//  Medl
//
//  Created by Ashish Soni on 17/07/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class EnterAddress_IpadVC: BaseBackViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
       @IBOutlet weak var AddressTblView: UITableView!
       @IBOutlet weak var TblHeightConstraint: NSLayoutConstraint!//50
       
       @IBOutlet weak var AddressTxtFieldHeightConstraint: NSLayoutConstraint!//50
       
       @IBOutlet weak var AddressTxtField: MyTextField!
       @IBOutlet weak var AddressLine1TxtField: UITextField!
       @IBOutlet weak var AddressLine2TxtField: UITextField!
       @IBOutlet weak var TelephoneNumberTxtField: UITextField!
       @IBOutlet weak var BackUpTelephoneNumberTxtField: UITextField!
       @IBOutlet weak var areaTxtField: MyTextField!
       
       @IBOutlet weak var PickUpTImeCollectionView: UICollectionView!
       
       @IBOutlet weak var AddressViewHeightConstraint: NSLayoutConstraint!//390
       @IBOutlet weak var texyAddView: MyView!
       @IBOutlet weak var dateSlectView: MyView!
       @IBOutlet weak var textAddHeightConst: NSLayoutConstraint!
       
       fileprivate var selectedCell = Int()
       fileprivate var selectedAddress = Int()
       @IBOutlet weak var viewAddAddress: UIView!
       @IBOutlet weak var btnAddAddress: MyButton!
       @IBOutlet weak var btnClose: UIButton!
       @IBOutlet weak var btnAddAddressHeightConstraint: NSLayoutConstraint!//44
       @IBOutlet weak var btnCloseAddress: UIButton!
       @IBOutlet weak var btnCloseAddressHeightConstraint: NSLayoutConstraint!//20
       @IBOutlet weak var deleryaddreshightConsts: NSLayoutConstraint!
       @IBOutlet weak var delteaddressLbl: UILabel!
    @IBOutlet weak var selectDate: MyButton!
    var AddressListArray = [Any]()
       var AreaListArray = [Any]()
       var pickUpTimeArray: NSArray!
       var SelectedTime = String()
       var Area_Name_Array:[String] = []
       
       var DetailButtonFlag = Bool()
       var tabType = String()
       var SubCategoriesArray = [String]()
       var _idArray = NSMutableArray()
       var addar:NSArray!
       var pikar:NSArray!
       var idarray:NSArray!
       var pricearray:NSArray!
       var typeArray:NSArray!
       var address = [String]()
       var pikuptime = [String]()
       var deleveryDateNew:String!
       var timesatamp:Int64!
    var datenw:String!
    override func viewDidLoad() {
        super.viewDidLoad()
               self.AddressViewHeightConstraint.constant = 0
               self.btnCloseAddress.isHidden = true
               self.dateSlectView.layer.cornerRadius = 5
               self.dateSlectView.layer.borderColor = UIColor.lightGray.cgColor
               self.dateSlectView.layer.borderWidth = 2
               
               //self.title = "MEDL"
               self.pickUpTimeArray = ["09:00AM - 11:00AM","12:00PM - 05:00PM"]
               
               let LiberaryLayOut = UICollectionViewFlowLayout()
               LiberaryLayOut.itemSize = CGSize(width: screenWidth/2-35, height: 60)
               LiberaryLayOut.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
               LiberaryLayOut.minimumInteritemSpacing = 10
               LiberaryLayOut.minimumLineSpacing = 10
               LiberaryLayOut.scrollDirection = .horizontal
               
               let LayOutClassNearBy = UINib(nibName: "PickUpTime_IpadCollectionCell", bundle: nil)
               self.PickUpTImeCollectionView.register(LayOutClassNearBy, forCellWithReuseIdentifier: "PickUpTime_IpadCollectionCell")
               self.PickUpTImeCollectionView.collectionViewLayout = LiberaryLayOut
               
               let nibClass = UINib(nibName: "Address_IpadTableCell", bundle: nil)
               self.AddressTblView.register(nibClass, forCellReuseIdentifier: "Address_IpadTableCell")
               self.AddressTblView.estimatedRowHeight = 60
               self.AddressTblView.rowHeight = UITableView.automaticDimension
               self.AddressTblView.dataSource = self
               self.AddressTblView.delegate = self
               self.AddressTblView.tableFooterView = UIView()
               self.AddressTblView.sectionHeaderHeight = 0
               self.AddressTblView.separatorStyle = .none
               self.TblHeightConstraint.constant = 0
        
                 UserDefaults.standard.removeObject(forKey: "date")
               
               
               self.AddressList_API()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
       // address.removeAll()
        //pikuptime.removeAll()
        
        
        datenw = UserDefaults.standard.value(forKey: "date") as? String
        if datenw == nil || datenw == "" {
            
        }else {
            self.selectDate.setTitle("  " + datenw, for: .normal)
            let dfmatter = DateFormatter()
            dfmatter.dateFormat="dd MMM yyyy"
            let date = dfmatter.date(from: datenw)
            timesatamp = date!.millisecondsSince1970
            print(timesatamp!)
        }
        
        
    }
    @IBAction func selectDateBtnAction(_ sender: Any) {
        let vc = CalenderIPADViewController(nibName: "CalenderIPADViewController", bundle: nil)
        self.onlyPushViewController(vc)
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
                    // self.TblHeightConstraint.constant = CGFloat(self.AddressListArray.count*60)
                    self.TblHeightConstraint.constant = 0
                    self.AddressTblView.reloadData()
                    
                    let categories_list =  DataManager.getVal(responseData?.object(forKey: "data"))  as! [NSDictionary]
                    
                    for categoriesData in categories_list {
                        let street = categoriesData.object(forKey: "street") as? String ?? ""
                        let add  = categoriesData.object(forKey: "add") as? String ?? ""
                        let add2  = categoriesData.object(forKey: "add2") as? String ?? ""
                        let Address = ("\(street),\(add),\(add2)")
                        
                        self.SubCategoriesArray.append(Address)
                        self.address = [Address]
                        print(self.SubCategoriesArray)
                    }
                    
                }else{
                    Config().error(message: message)
                }
            }
            self.clearHud()
        }
    }
    
    @IBAction func btnAddNewAddress(_ sender: UIButton) {
            self.AddressTxtFieldHeightConstraint.constant = 0
            self.AddressTxtField.isHidden = true
            self.btnClose.isHidden = false
            self.btnAddAddress.isHidden = true
            self.btnAddAddressHeightConstraint.constant = 0
            self.viewAddAddress.isHidden = false
            self.AddressTxtField.text = ""
            self.textAddHeightConst.constant  = 0
            self.texyAddView.isHidden = true
            self.deleryaddreshightConsts.constant = 0
            self.delteaddressLbl.isHidden = true
            self.AddressViewHeightConstraint.constant = 400
            self.areaTxtField.text = "  \("")"
            
        }
        
        @IBAction func btnCloseAddress(_ sender: Any) {
            self.AddressTxtFieldHeightConstraint.constant = 50
            self.AddressTxtField.isHidden = false
            self.AddressLine1TxtField.text = ""
            self.AddressLine2TxtField.text = ""
            self.TelephoneNumberTxtField.text = ""
            self.BackUpTelephoneNumberTxtField.text = ""
            self.btnClose.isHidden = true
            self.btnAddAddressHeightConstraint.constant = 44
            self.btnAddAddress.isHidden = false
            self.viewAddAddress.isHidden = true
            self.textAddHeightConst.constant  = 154
            self.texyAddView.isHidden = false
            self.deleryaddreshightConsts.constant = 27
            self.delteaddressLbl.isHidden = false
            self.AddressViewHeightConstraint.constant = 0
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
                                StringPickerPopover(title: "Area list", choices: city)
                                .setSelectedRow(0)
                                
                                .setDoneButton(title: "Done", color: Config().AppWhiteColor, action: { (popover, selectedRow, selectedString) in
                                    
                                    print("done row \(selectedRow) \(selectedString)")
                                    self.areaTxtField.text = ("  \(selectedString )")
                                   // self.AddressTxtField.text = selectedString
                                   // self.AddressTxtField.resignFirstResponder()
                                    
                                })
                                
                                .setCancelButton(title: "Cancel", color: Config().AppWhiteColor, action: { (_, _, _) in
                                    print("Cancel")
                                })
                                .appear(originView: self.areaTxtField, baseViewController: self)
//                                DPPickerManager.shared.showPicker(title: "Area list", selected: "", strings: city) { (value, index, cancel) in
//                                    if !cancel {
//                                        self.areaTxtField.text = ("  \(value ?? "")")
//                                        print(value!)
//                                    }
//                                }
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
        
        
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
        
        @IBAction func NextButtonAction(_ sender: MyButton) {

            DetailButtonFlag = true
            if tabType == "Pending" {
            
            if self.AddressViewHeightConstraint.constant == 390{
                if ValidationClass().Validate_Address_Form1(self){
                    self.showHud()
                    let parameterDictionary = NSMutableDictionary()
    //                parameterDictionary.setValue(DataManager.getVal(""), forKey: "street")
                    parameterDictionary.setValue(DataManager.getVal(self.AddressLine1TxtField.text!), forKey: "street")
                    parameterDictionary.setValue(DataManager.getVal(self.AddressLine2TxtField.text!), forKey: "add")
                    parameterDictionary.setValue(DataManager.getVal(self.TelephoneNumberTxtField.text!), forKey: "phoneNumber")
                    parameterDictionary.setValue(DataManager.getVal(self.BackUpTelephoneNumberTxtField.text!), forKey: "extNumber")
                    parameterDictionary.setValue(DataManager.getVal(self.SelectedTime), forKey: "pickUpTime")
                    parameterDictionary.setValue(DataManager.getVal(self.areaTxtField.text!), forKey: "area")

                    print(parameterDictionary)
                    
                    let methodName = "/deliveryDetails"
                    
                    getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
                        if error == nil{
                            let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                            let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                            
                            if success == "1"{
                               
                                print(self.idarray ?? "")
                                print(self.pricearray ?? "")
                                  self.address = [ self.AddressLine1TxtField.text! + "," + self.areaTxtField.text! + ","]
                                self.addar = self.address as? NSArray
                                self.pikar = self.pikuptime as? NSArray
                                
                                for i in 0..<self.idarray.count {
                                   // for j in 0..<prar.count {
                                      var dictPaitient = [String:Any]()
                                      var id:String!
                                    id = self.idarray.object(at: i) as? String
//                                      var addr:String!
//                                    addr = self.addar.object(at: i) as? String
//                                      var pikup:String!
//                                    pikup = self.pikar.object(at: i) as? String
                                    var addr:String!
                                    for j in 0..<self.addar.count {
                                        addr = self.addar.object(at: j) as? String
                                     }
                                    
                                     var pikup:String!
                                    for k in 0..<self.pikar.count {
                                        pikup = self.pikar.object(at: k) as? String
                                     }
                                      dictPaitient = ["id": id!,
                                                      "type": "",
                                                      "address":addr!,
                                                      "pickUpTime":pikup!,
                                                      "deliveryDate":self.timesatamp!]
                                     print(dictPaitient)
                                    self._idArray.add(dictPaitient)
                                   // }
                                }
                                print(self._idArray)
                                
                                Config().success(message: message)
                                let vc = PaymentDetailsVC(nibName: "PaymentDetailsVC", bundle: nil)
                                vc.ns = self._idArray
                                self.onlyPushViewController(vc)
                                self.AddressTxtField.text = ""
                                self.AddressLine1TxtField.text = ""
                                self.AddressLine2TxtField.text = ""
                                self.TelephoneNumberTxtField.text = ""
                                self.BackUpTelephoneNumberTxtField.text = ""
                                self.areaTxtField.text = ""
                            }else{
                                Config().error(message: message)
                            }
                        }
                        self.clearHud()
                    }
                }
            }else{
                if self.AddressTxtField.text == ""{
                    Config().error(message: "Please Select Prefferd Address?")
                }else if self.datenw == "" || self.datenw ==  nil{
                    Config().error(message: "Please select date?")
                }
                else{
                print(idarray ?? "")
                print(pricearray ?? "")
                
                addar = address as? NSArray
                pikar = pikuptime as? NSArray
                
                for i in 0..<idarray.count {
                   // for j in 0..<prar.count {
                      var dictPaitient = [String:Any]()
                      var id:String!
                      id = idarray.object(at: i) as? String
//                      var addr:String!
//                      addr = addar.object(at: i) as? String
//                      var pikup:String!
//                      pikup = pikar.object(at: i) as? String
                    var addr:String!
                    for j in 0..<self.addar.count {
                        addr = self.addar.object(at: j) as? String
                     }
                    
                     var pikup:String!
                    for k in 0..<self.pikar.count {
                        pikup = self.pikar.object(at: k) as? String
                     }
                      dictPaitient = ["id": id!,
                                      "type": "",
                                      "address":addr!,
                                      "pickUpTime":pikup!,
                                      "deliveryDate":timesatamp!]
                     print(dictPaitient)
                     _idArray.add(dictPaitient)
                   // }
                }
                print(_idArray)
                
                
                let vc = PaymentInfoVC_Ipad(nibName: "PaymentInfoVC_Ipad", bundle: nil)
                vc.ns = _idArray
                self.onlyPushViewController(vc)
                }
            }
            }else if tabType == "Active" {
                if self.AddressViewHeightConstraint.constant == 390{
                            if ValidationClass().Validate_Address_Form1(self){
                                self.showHud()
                                let parameterDictionary = NSMutableDictionary()
                //                parameterDictionary.setValue(DataManager.getVal(""), forKey: "street")
                                parameterDictionary.setValue(DataManager.getVal(self.AddressLine1TxtField.text!), forKey: "street")
                                parameterDictionary.setValue(DataManager.getVal(self.AddressLine2TxtField.text!), forKey: "add")
                                parameterDictionary.setValue(DataManager.getVal(self.TelephoneNumberTxtField.text!), forKey: "phoneNumber")
                                parameterDictionary.setValue(DataManager.getVal(self.BackUpTelephoneNumberTxtField.text!), forKey: "extNumber")
                                parameterDictionary.setValue(DataManager.getVal(self.SelectedTime), forKey: "pickUpTime")
                                parameterDictionary.setValue(DataManager.getVal(self.areaTxtField.text!), forKey: "area")

                                print(parameterDictionary)
                                
                                let methodName = "/deliveryDetails"
                                
                                getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
                                    if error == nil{
                                        let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                                        let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                                        
                                        if success == "1"{
                                           
                                            
                                            print(self.idarray ?? "")
                                            print(self.pricearray ?? "")
                                              self.address = [ self.AddressLine1TxtField.text! + "," + self.areaTxtField.text! + ","]
                                            self.addar = self.address as? NSArray
                                            self.pikar = self.pikuptime as? NSArray
                                           
                                            for i in 0..<self.idarray.count {
                                              // for j in 0..<prar.count {
                                                 var dictPaitient = [String:Any]()
                                                 var id:String!
                                                id = self.idarray.object(at: i) as? String
                                                // var price:String!
                                                // price = pricearray.object(at: i) as? String
//                                                 var addr:String!
//                                                addr = self.addar.object(at: i) as? String
//                                                 var pikup:String!
//                                                pikup = self.pikar.object(at: i) as? String
                                                // var type:String!
                                               //  type = typeArray.object(at: i) as? String
                                                var addr:String!
                                                for j in 0..<self.addar.count {
                                                    addr = self.addar.object(at: j) as? String
                                                 }
                                                
                                                 var pikup:String!
                                                for k in 0..<self.pikar.count {
                                                    pikup = self.pikar.object(at: k) as? String
                                                 }
                                                 dictPaitient = ["id": id!,
                                                                 "address":addr!,
                                                                 "pickUpTime":pikup!,
                                                                 "type":"refill",
                                                                 "deliveryDate":self.timesatamp!]
                                                print(dictPaitient)
                                                self._idArray.add(dictPaitient)
                                              // }
                                           }
                                            print(self._idArray)
                                            
                                            Config().success(message: message)
                                            let vc = PaymentDetailsVC(nibName: "PaymentDetailsVC", bundle: nil)
                                            vc.ns = self._idArray
                                            self.onlyPushViewController(vc)
                                            self.AddressTxtField.text = ""
                                            self.AddressLine1TxtField.text = ""
                                            self.AddressLine2TxtField.text = ""
                                            self.TelephoneNumberTxtField.text = ""
                                            self.BackUpTelephoneNumberTxtField.text = ""
                                            self.areaTxtField.text = ""
                                        }else{
                                            Config().error(message: message)
                                        }
                                    }
                                    self.clearHud()
                                }
                            }
                        }else{
                            if self.AddressTxtField.text == ""{
                                Config().error(message: "Please Select Prefferd Address?")
                            }else{
                            
                            print(idarray ?? "")
                            print(pricearray ?? "")
                            
                            addar = address as? NSArray
                            pikar = pikuptime as? NSArray
                            
                            for i in 0..<idarray.count {
                               // for j in 0..<prar.count {
                                  var dictPaitient = [String:Any]()
                                  var id:String!
                                  id = idarray.object(at: i) as? String
                                 // var price:String!
                                 // price = pricearray.object(at: i) as? String
//                                  var addr:String!
//                                  addr = addar.object(at: i) as? String
//                                  var pikup:String!
//                                  pikup = pikar.object(at: i) as? String
                                var addr:String!
                                for j in 0..<self.addar.count {
                                    addr = self.addar.object(at: j) as? String
                                 }
                                
                                 var pikup:String!
                                for k in 0..<self.pikar.count {
                                    pikup = self.pikar.object(at: k) as? String
                                 }
                                 // var type:String!
                                //  type = typeArray.object(at: i) as? String
                                  dictPaitient = ["id": id!,
                                                  "address":addr!,
                                                  "pickUpTime":pikup!,
                                                  "type":"refill",
                                                  "deliveryDate":timesatamp!]
                                 print(dictPaitient)
                                 _idArray.add(dictPaitient)
                               // }
                            }
                            print(_idArray)
                            
                            
                            let vc = PaymentInfoVC_Ipad(nibName: "PaymentInfoVC_Ipad", bundle: nil)
                            vc.ns = _idArray
                            self.onlyPushViewController(vc)
                    }
                }
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return pickUpTimeArray.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickUpTime_IpadCollectionCell", for: indexPath) as! PickUpTime_IpadCollectionCell
            cell.TitleLbl.text = pickUpTimeArray[indexPath.row] as? String ?? ""
            cell.layer.cornerRadius = 6
            self.SelectedTime =  self.pickUpTimeArray.firstObject as? String ?? ""
            self.pikuptime = [SelectedTime]
            print(pikuptime)
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
            self.SelectedTime =  self.pickUpTimeArray[indexPath.row] as? String ?? ""
            self.pikuptime = [SelectedTime]
            self.PickUpTImeCollectionView.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.AddressListArray.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Address_IpadTableCell", for: indexPath) as! Address_IpadTableCell
            let dict = DataManager.getVal(self.AddressListArray[indexPath.row]) as! NSDictionary
            let street = DataManager.getVal(dict["street"]) as? String ?? ""
            let add2 = DataManager.getVal(dict["add"]) as? String ?? ""
            let phoneNumber = DataManager.getVal(dict["phoneNumber"]) as? String ?? ""
            let pickUPTime = DataManager.getVal(dict["pickUPTime"]) as? String ?? ""
            
            cell.AddressLbl.text = street + add2
            cell.phoneNumberLbl.text = "Phone: \(phoneNumber)"
            cell.pickUpTimeLbl.text = "Pick Time: \(pickUPTime)"
           // address = street + add2
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.selectedAddress = indexPath.row
            let dict = DataManager.getVal(self.AddressListArray[indexPath.row]) as! NSDictionary
            let add = DataManager.getVal(dict["add"]) as? String ?? ""
    //        let add2 = DataManager.getVal(dict["add2"]) as? String ?? ""
            let phoneNumber = DataManager.getVal(dict["phoneNumber"]) as? String ?? ""
            let phoneNumber2 = DataManager.getVal(dict["phoneNumber2"]) as? String ?? ""
            let street = DataManager.getVal(dict["street"]) as? String ?? ""
            address = [street + add]
            self.AddressTxtField.text = street
            self.AddressLine1TxtField.text = add
    //        self.AddressLine2TxtField.text = add2
            self.TelephoneNumberTxtField.text = phoneNumber
            self.BackUpTelephoneNumberTxtField.text = phoneNumber2
            
        }
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            if textField == self.AddressTxtField{
                self.view.endEditing(true)
                
                if self.SubCategoriesArray.count != 0 {
                    StringPickerPopover(title: "Address", choices: self.SubCategoriesArray)
                        .setSelectedRow(0)
                        
                        .setDoneButton(title: "Done", color: Config().AppWhiteColor, action: { (popover, selectedRow, selectedString) in
                            
                            print("done row \(selectedRow) \(selectedString)")
                            self.address = [selectedString]
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
            }else if textField == self.areaTxtField{
                self.view.endEditing(true)
                self.areaList_API()
                return false
            }
            else{
                return true
            }
//            if textField == self.AddressTxtField{
//                DPPickerManager.shared.showPicker(title: "Address", selected: "", strings: self.SubCategoriesArray) { (value, index, cancel) in
//                    if !cancel {
//                        self.AddressTxtField.text = value
//                    } else {
//
//                    }
//                    self.address = [("  \(value ?? "")")]
//                }
//                return false
//            }else if textField == self.areaTxtField{
//                self.view.endEditing(true)
//                self.areaList_API()
//                return false
//            }else{
//                return true
//            }
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
