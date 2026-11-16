//
//  DasboardDetail_IpadVC.swift
//  Medl
//
//  Created by Ashish Soni on 16/07/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit



class DasboardDetail_IpadVC: BaseBackViewController,UITableViewDataSource, UITableViewDelegate {

   // @IBOutlet weak var PaymentTblView: UITableView!
       var str_id = String()
       
       @IBOutlet weak var RxImage: UIImageView!
       @IBOutlet weak var PriceView: UIView!
       @IBOutlet weak var detailView: UIView!
       @IBOutlet weak var prescriptionDetailView: UIView!
       
       var DetailButtonFlag = Bool()
       var tabType = String()
       
       @IBOutlet weak var scrollView: UIScrollView!
        var subtituteProduct = [Any]()
       var selectedIds = [Int] ()
       var medArray:NSMutableArray!
       @IBOutlet weak var constarint_height_drugsList: NSLayoutConstraint!
       @IBOutlet weak var constarint_height_drugdetailsView: NSLayoutConstraint!
       @IBOutlet weak var constarint_height_prescriptionView: NSLayoutConstraint!
       @IBOutlet weak var btn_DisplayDrugList: UIButton!
       @IBOutlet weak var BackView: MyView!
       @IBOutlet weak var titleLbl: UILabel!
       @IBOutlet weak var DrNameLbl: UILabel!
       @IBOutlet weak var QuantityLbl: UILabel!
       @IBOutlet weak var DurationLbl: UILabel!
       @IBOutlet weak var FrequencyLbl: UILabel!
       @IBOutlet weak var RouteLbl: UILabel!
       @IBOutlet weak var RefillsLbl: UILabel!
       @IBOutlet weak var PriceLbl: UILabel!
//       @IBOutlet weak var RefillCheckButton: ResponsiveButton!
//       @IBOutlet weak var lbl_AutomaticallyRefillPrescription: UILabel!
       @IBOutlet weak var DeclineButtonOutlet: MyButton!
       @IBOutlet weak var ConfirmButtonOutlet: MyButton!
       @IBOutlet weak var constraint_view_bottom: NSLayoutConstraint!
       @IBOutlet weak var btn_Presciption_Details: UIButton!
       @IBOutlet weak var doctor_Notes: UITextView!
       @IBOutlet weak var img_tablet: UIImageView!
       @IBOutlet weak var StrengthLbl: UILabel!
       @IBOutlet weak var DosagesformLbl: UILabel!
       @IBOutlet weak var showRefillLbl: UILabel!
       
       @IBOutlet weak var more_detailBtn: UIButton!
       
       @IBOutlet weak var constraint_height_detailView: NSLayoutConstraint!
       
       
       @IBOutlet weak var moredetailview: UIView!
       
       @IBOutlet weak var pnLbl: UILabel!
       
       @IBOutlet weak var pidLbl: UILabel!
       
       @IBOutlet weak var rnLbl: UILabel!

       @IBOutlet weak var dqtitlelbl: UILabel!
       @IBOutlet weak var dpLbl: UILabel!
       @IBOutlet weak var dpTitleLbl: UILabel!
       @IBOutlet weak var dqapidataLbl: UILabel!
       @IBOutlet weak var dqdetailapiDataLbl: UILabel!
       
       @IBOutlet weak var predateTitleLbl: UILabel!
       var selectedArray: NSMutableArray!
       var data_Array = [Any]()
       var detail_Arrar = [Any]()
       var mecArray:NSArray!
       var tabletArray = [Any]()
       var detail_Data_Dict = [String: Any]()
       var doctor_data_dict = [String: Any]()
       var SelectValue  = -1
       var buttonCounter = NSMutableArray()
       var itemPrice = [String]()
       var itemId = [String]()
       var itemRefill = [String]()
       var currentStat = Stat()
       var filteredArray : [StatEvents] = []
       var DeclineButton = UIButton()
       var ConfirmButton = UIButton()
       var fullNameLbl = UILabel()
       var lastSelectedIndexPath = IndexPath(row: -1, section: 0)
       var refillButton = UIButton()
       var medBatchArray = NSArray()
       var prscribeamount:Int!
       var priscribelabellerr:String!
       var pricetotal:String!
       var priscrinametxt:String!
       var taxlbl:String!
       var selectty:String!
       @IBOutlet weak var productbatchName: UILabel!
       @IBOutlet weak var productBatchPrice: UILabel!
       @IBOutlet weak var checkBtnNew: UIButton!
       @IBOutlet weak var PaymentTblView: UITableView!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.itemId.append(str_id)
           self.doctor_Notes.layer.borderColor = Config().AppGrayColor.cgColor
           self.doctor_Notes.layer.borderWidth = 1.0
           
   //        self.img_tablet.layer.cornerRadius = 3
   //
   //        // border
   //        self.img_tablet.layer.borderWidth = 0.5
   //        self.img_tablet.layer.borderColor = UIColor.gray.cgColor
   //
   //        // shadow
   //        self.img_tablet.layer.shadowColor = UIColor.black.cgColor
   //        self.img_tablet.layer.shadowOffset = CGSize(width: 3, height: 3)
   //        self.img_tablet.layer.shadowOpacity = 0.7
   //        self.img_tablet.layer.shadowRadius = 5.0
        
        
      
           btn_DisplayDrugList.isSelected = false
           self.showRefillLbl.isHidden = true
           
           if DetailButtonFlag == true{
             //  self.DeclineButtonOutlet.isHidden = true
             //  self.ConfirmButtonOutlet.isHidden = true
             //  self.PaymentTblView.isHidden = false
               self.BackView.shadowRadius = 2
               self.BackView.layer.shadowOpacity = 2
               self.BackView.layer.shadowOffset = .init(width: 2, height: 2)
               self.DeclineButton.isHidden = false
               self.ConfirmButton.isHidden = false
           }else{
              // self.DeclineButtonOutlet.isHidden = true
             //  self.ConfirmButtonOutlet.isHidden = true
              // self.PaymentTblView.isHidden = true
               self.BackView.shadowRadius = 0
               self.BackView.layer.shadowOpacity = 0
               self.BackView.layer.shadowOffset = .init(width: 0, height: 0)
               self.DeclineButton.isHidden = true
               self.ConfirmButton.isHidden = true
           }
           
//           let nibClass = UINib(nibName: "PaymentTableCell", bundle: nil)
//           self.PaymentTblView.register(nibClass, forCellReuseIdentifier: "PaymentTableCell")
//           self.PaymentTblView.estimatedRowHeight = 60
//           self.PaymentTblView.rowHeight = UITableView.automaticDimension
//           self.PaymentTblView.dataSource = self
//           self.PaymentTblView.delegate = self
//           self.PaymentTblView.tableFooterView = UIView()
//           self.PaymentTblView.sectionHeaderHeight = 0
//           self.PaymentTblView.separatorStyle = .none
//
           
         
           self.viewPrescriptionsDetail_API()
           
           if self.tabType == "InProcess"{
               self.dqtitlelbl.isHidden = true
               self.dqapidataLbl.isHidden = true
               self.dqdetailapiDataLbl.isHidden = true
               self.dpTitleLbl.isHidden = true
               self.dpLbl.isHidden = true
              // self.DeclineButton.isHidden = true
             //  self.ConfirmButton.isHidden = true
               self.RxImage.image = UIImage(named: "Group 4")
               self.img_tablet.image = UIImage(named: "LeftIcon")
               self.img_tablet.isHidden = false
               self.PriceView.backgroundColor = Config().AppGreenColor
               self.DeclineButtonOutlet.isHidden = true
               self.ConfirmButtonOutlet.isHidden = true
               self.constraint_view_bottom.constant = 150
              // self.PaymentTblView.isHidden = true
               self.PriceView.isHidden = true
               self.btn_DisplayDrugList.isHidden = false
               self.scrollView.isScrollEnabled = true
              // self.PaymentTblView.isScrollEnabled = false
               self.predateTitleLbl.text = "PRECRIPTION ISSUE DATE"
               let my_lbl = UILabel()
               my_lbl.text = "This prescription is being processed by the medl pharmacy team."
               my_lbl.textAlignment = .center
               my_lbl.numberOfLines = 0
               my_lbl.layer.borderWidth = 1
               my_lbl.layer.borderColor = UIColor.lightGray.cgColor
               my_lbl.layer.cornerRadius = 3
               my_lbl.layer.shadowColor = UIColor.lightGray.cgColor
               my_lbl.layer.shadowRadius = 3.0
               my_lbl.layer.shadowOpacity = 1.0
               my_lbl.layer.shadowOffset = CGSize(width: 4, height: 4)
               my_lbl.layer.masksToBounds = false
               my_lbl.backgroundColor = Config().AppWhiteColor
               self.view.addSubview(my_lbl)
               my_lbl.translatesAutoresizingMaskIntoConstraints = false
               my_lbl.heightAnchor.constraint(equalToConstant: 70).isActive = true
               my_lbl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-100).isActive = true
               my_lbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
               my_lbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
           }else if self.tabType == "Pending"{
               self.RxImage.image = UIImage(named: "Group 3")
               self.img_tablet.image = UIImage(named: "LeftIcon")
               self.PriceView.backgroundColor = Config().AppGreenColor
               self.scrollView.isScrollEnabled = true
               self.img_tablet.isHidden = false
               self.detailView.isHidden = false
              // self.PaymentTblView.isHidden = true
               self.dqtitlelbl.isHidden = true
               self.dqapidataLbl.isHidden = true
               self.dqdetailapiDataLbl.isHidden = true
               self.dpTitleLbl.isHidden = true
               self.dpLbl.isHidden = true
               self.DeclineButtonOutlet.isHidden = false
               self.ConfirmButtonOutlet.isHidden = false
               self.predateTitleLbl.text = "PRECRIPTION ISSUE DATE"
           }else if self.tabType == "Active"{
               self.DeclineButtonOutlet.isHidden = true
               self.ConfirmButtonOutlet.isHidden = true
               self.RxImage.image = UIImage(named: "Group 2")
               self.img_tablet.image = UIImage(named: "LeftIcon")
             //  self.PaymentTblView.isHidden = true
               self.predateTitleLbl.text = "PRECRIPTION FILL DATE"
               self.scrollView.isScrollEnabled = true
               self.PriceView.isHidden = true
               self.PriceView.backgroundColor = Config().AppGreenColor
               refillButton.backgroundColor = Config().AppNavBlueColor
               refillButton.setTitle("Refill", for: .normal)
               refillButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
               refillButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
               refillButton.titleLabel?.numberOfLines = 2
               refillButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
               refillButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
               refillButton.addTarget(self, action: #selector(RefillActionButton(_:)), for: .touchUpInside)
               self.BackView.addSubview(refillButton)
               refillButton.translatesAutoresizingMaskIntoConstraints = false
               refillButton.layer.cornerRadius = 20
               refillButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
               refillButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
               refillButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 350).isActive = true
              // refillButton.center = CGPoint(x: 100, y: 100)
               refillButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
               self.dqtitlelbl.isHidden = false
               self.dqapidataLbl.isHidden = false
               self.dqdetailapiDataLbl.isHidden = false
               self.dpTitleLbl.isHidden = false
               self.dpLbl.isHidden = false
           }else{
               self.RxImage.image = UIImage(named: "Group 14")
               self.PriceView.backgroundColor = Config().AppGreenColor
               self.predateTitleLbl.text = "PRECRIPTION FILL DATE"
               
           }
//               DeclineButton.backgroundColor = Config().AppGrayColor
//               DeclineButton.setTitle(" DECLINE ORDER", for: .normal)
//               DeclineButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
//               DeclineButton.titleLabel?.numberOfLines = 2
//               DeclineButton.titleLabel?.textAlignment = .center
//               DeclineButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
//               DeclineButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//               DeclineButton.addTarget(self, action: #selector(DeclinePurchaseButtonAction(_:)), for: .touchUpInside)
//               self.view.addSubview(DeclineButton)
//               DeclineButton.translatesAutoresizingMaskIntoConstraints = false
//               DeclineButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//               DeclineButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
//               DeclineButton.layer.borderColor = UIColor.systemGray.cgColor
//               DeclineButton.layer.borderWidth = 1
//               DeclineButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
//               DeclineButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//
//               ConfirmButton.backgroundColor = UIColor(red: 91/255, green: 172/255, blue: 156/255, alpha: 1)
//               ConfirmButton.setTitle(" CONFIRM ORDER", for: .normal)
//               ConfirmButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
//               ConfirmButton.titleLabel?.numberOfLines = 2
//               ConfirmButton.titleLabel?.textAlignment = .center
//               ConfirmButton.addTarget(self, action: #selector(ConfirmPurchaseButtonAction(_:)), for: .touchUpInside)
//               self.view.addSubview(ConfirmButton)
//               ConfirmButton.translatesAutoresizingMaskIntoConstraints = false
//               ConfirmButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//               ConfirmButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
//               ConfirmButton.layer.borderColor = UIColor.systemGray.cgColor
//               ConfirmButton.layer.borderWidth = 1
//               ConfirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
//               ConfirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
           
   //        SocketIoManager.sharedInstance.establishConnection()
       }
    
    
   
       
       @objc func RefillActionButton(_ sender: UIButton){
           
           let vc = EnterAddress_IpadVC(nibName: "EnterAddress_IpadVC", bundle: nil)
           DetailButtonFlag = true
           vc.DetailButtonFlag = DetailButtonFlag
           vc.tabType = "Active"
           vc.idarray = itemId as? NSArray
           vc.pricearray = itemPrice as? NSArray
           vc.typeArray = itemRefill as? NSArray
           self.onlyPushViewController(vc)
           
       }
    
    @IBAction func checkBtnNewAction(_ sender: Any) {
           self.buttonCounter.removeAllObjects()
           self.PaymentTblView.reloadData()
           self.checkBtnNew.setImage(UIImage(named: "GreenRadioButtonActive"), for: .normal)
           self.selectty = "Single"
           
       }
    @IBAction func declineBtnAction(_ sender: Any) {
        let alertControl = UIAlertController(title: "Decline Order", message: "Are you sure you want to decline your order?", preferredStyle: .alert)
                  
                  let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
                          
                          var dictPaitient = [String:Any]()
                          dictPaitient = ["type": "decline","id": self.str_id]
                          
                          let typeIdArrayStringnew = self.JSONStringify(value: dictPaitient as AnyObject)
                          SocketIoManager.sharedInstance.sendMessage(withSender: typeIdArrayStringnew)
                          SocketIoManager.sharedInstance.connectToServerWithSecondRoom(nickname: typeIdArrayStringnew)
                          NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvert3(_:)), name: NSNotification.Name("notificationNameStudent3"), object: nil)
                         // let vc = DashBoard(nibName: "DashBoard", bundle: nil)
                        //  self.RootViewControllerWithNav(vc)
                         // self.orderCSRApi()
                    }
                  let action2 = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
                  }
                  alertControl.addAction(action1)
                  alertControl.addAction(action2)
                  
                  self.present(alertControl, animated: true, completion: nil)
    }
    
    @IBAction func confiremBtnAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set("Array", forKey: "NewData")
        defaults.synchronize()
        self.PendingTap_API()
        NotificationCenter.default.post(name: NSNotification.Name("APICALL"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    @objc func DeclinePurchaseButtonAction(_ sender: UIButton) {
           
          
       }
       
       
         @objc func currencyConvert3(_ pNotification1: Notification?) {
           var dictmew = NSArray()
           dictmew = pNotification1?.object as! NSArray
           var messgae:String!
           for i in 0..<dictmew.count {
           var dict = NSDictionary()
               dict = dictmew.object(at: i) as! NSDictionary
               messgae = dict.object(forKey: "message") as? String
            }
           
           let vc = DashBoard(nibName: "DashBoard", bundle: nil)
           let alert = UIAlertController(title: "", message: messgae, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {action in self.RootViewControllerWithNav(vc)}))
           self.present(alert, animated: true, completion: nil)
               
       }
       
       func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{

              let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
              if JSONSerialization.isValidJSONObject(value) {
                  do{
                      let data = try JSONSerialization.data(withJSONObject: value, options: options)
                      if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                          return string as String
                      }
                  }catch {
                      print("error")
                  }
              }
              return ""
          }
       
       func orderCSRApi(){
           
           let str_prescriptionNumber = DataManager.getVal(self.detail_Data_Dict["prescriptionNumber"]) as? String ?? ""
           let typeName = DataManager.getVal(self.detail_Data_Dict["typeName"]) as? String ?? ""
           
           self.showHud()
           let parameterDictionary = NSMutableDictionary()
           parameterDictionary.setValue(DataManager.getVal(str_prescriptionNumber), forKey: "prescriptionNumber")
           parameterDictionary.setValue(DataManager.getVal(typeName), forKey: "typeName")
           
           print(parameterDictionary)
           
           let methodName = "/orderToCsr"
           
           getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
               if error == nil{
                   let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                   let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                   DispatchQueue.main.async {
                       if success == "1"{
                           
                           let vc = DashBoard(nibName: "DashBoard", bundle: nil)
                           self.RootViewControllerWithNav(vc)
                           
                       }else{
                           Config().error(message: message)
                       }
                       
                   }
                   self.clearHud()
               }
           }
           
       }

       @objc func ConfirmPurchaseButtonAction(_ sender: UIButton) {

           let defaults = UserDefaults.standard
           defaults.set("Array", forKey: "NewData")
           defaults.synchronize()
           self.PendingTap_API()
           NotificationCenter.default.post(name: NSNotification.Name("APICALL"), object: nil)
           navigationController?.popViewController(animated: true)
       
       }
      func viewPrescriptionsDetail_API(){
              
              self.showHud()
              let parameterDictionary = NSMutableDictionary()
              print(parameterDictionary)
              
              let methodName = "/viewPrescriptionsDetail?_id=\(str_id)"
              
              getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
                  if error == nil{
                      let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                      let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                      
                      if success == "1"{
                          
                          self.detail_Data_Dict = DataManager.getVal(responseData?.object(forKey: "data")) as! [String: Any]
                          print(self.detail_Data_Dict)
                          let pharmaNotes = DataManager.getVal(self.detail_Data_Dict["pharmaNotes"]) as? String ?? ""
                          let allowsubSts = DataManager.getVal(self.detail_Data_Dict["allowSubstitutes"]) as? String ?? ""
                          let prscribeamount1 = DataManager.getVal(self.detail_Data_Dict["prescribedAmount"]) as? String ?? ""
                         
                          let productName = DataManager.getVal(self.detail_Data_Dict["typeName"]) as? String ?? ""
                          self.productbatchName.text = productName
                          self.prscribeamount = Int(prscribeamount1)
                         
                          if allowsubSts == "1" {
                              self.constarint_height_drugsList.constant = 208
                              self.PaymentTblView.isHidden = false
                          }else {
                              self.constarint_height_drugsList.constant = 0
                              self.PaymentTblView.isHidden = true
                          }
                          self.tabletArray = DataManager.getVal(responseData?.object(forKey: "priceDetail")) as? [Any] ?? []
                          
                          print(self.tabletArray as Any)
                          if self.tabletArray.count == 0{
                              print("data nhi h")
                          }else{
                              if let data1 = self.tabletArray[0] as? NSDictionary{
                                  let route = DataManager.getVal(data1["route"]) as? String ?? ""
                                  let strength = DataManager.getVal(data1["strength"]) as? String ?? "---"
                                  let dosageForm = DataManager.getVal(data1["dosageForm"]) as? String ?? ""
                                  let taxper = DataManager.getVal(data1["taxPercentage"]) as? String ?? ""
                                  self.taxlbl = taxper
                                  self.subtituteProduct = DataManager.getVal(data1["substituteProduct"]) as? [Any] ?? []
                                  if self.subtituteProduct.count == 0 {
                                      self.constarint_height_drugsList.constant = 0
                                      self.PaymentTblView.isHidden = true
                                  }else {
                                      self.constarint_height_drugsList.constant = 208
                                      self.PaymentTblView.isHidden = false
                                  }
                                  self.medBatchArray = DataManager.getVal(data1["medicineBatch"]) as! NSArray
                                  let dictnew = self.medBatchArray.lastObject as? NSDictionary
                                  var pricebatch:Int!
                                  pricebatch = dictnew!.value(forKey: "price") as? Int
                                  var pricetotal:Int!
                                  pricetotal = self.prscribeamount*pricebatch
                                  self.productBatchPrice.text = "$\(String(pricetotal) ?? "0").00"
                                  self.RouteLbl.text = route
                                  self.StrengthLbl.text = strength
                                  self.DosagesformLbl.text = dosageForm

                              }
                          }

                          self.doctor_data_dict = DataManager.getVal(self.detail_Data_Dict["doctorId"]) as! [String: Any]
                          let firstName = DataManager.getVal(self.doctor_data_dict["firstName"]) as? String ?? ""
                          let lastName = DataManager.getVal(self.doctor_data_dict["lastName"]) as? String ?? ""
                          let fullName = DataManager.getVal(self.doctor_data_dict["fullName"]) as? String ?? ""
                          let typeName = DataManager.getVal(self.detail_Data_Dict["typeName"]) as? String ?? ""
      //                    let formulationName = DataManager.getVal(self.detail_Data_Dict["recommendedFormulation"]) as? String ?? ""
                          let duration = DataManager.getVal(self.detail_Data_Dict["duration"]) as? String ?? ""
                          let frequency = DataManager.getVal(self.detail_Data_Dict["frequency"]) as? String ?? ""
                          let refill = DataManager.getVal(self.detail_Data_Dict["refill"]) as? String ?? ""
                          let pricePerPec = DataManager.getVal(self.detail_Data_Dict["pricePerPec"]) as? String ?? ""
                          let quantity = DataManager.getVal(self.detail_Data_Dict["quantity"]) as? String ?? ""
                          let notes = DataManager.getVal(self.detail_Data_Dict["notes"]) as? String ?? ""
                          let schedule = DataManager.getVal(self.detail_Data_Dict["schedule"]) as? String ?? ""
                          self.itemRefill.append("refill")
                          self.DrNameLbl.text = "DR. \(firstName.capitalizingFirstLetter() + lastName)"
      //                    self.titleLbl.text = typeName
      //                    self.titleLbl.text = "\(formulationName): \(typeName)"
                          self.DurationLbl.text = (duration + ("  \(schedule)"))
                          self.FrequencyLbl.text = frequency
                          self.doctor_Notes.text = notes
                          self.QuantityLbl.text = quantity
                          self.RefillsLbl.text = refill
                          self.pnLbl.text = DataManager.getVal(self.detail_Data_Dict["prescriptionNumber"]) as? String ?? ""
                          var time:String!
                          if self.tabType == "Pending" {
                              time = DataManager.getVal(self.detail_Data_Dict["createdAt"]) as? String ?? ""
                          }else if self.tabType == "Active" {
                              time = DataManager.getVal(self.detail_Data_Dict["orderDate"]) as? String ?? ""
                          }else if self.tabType == "InProcess" {
                              time = DataManager.getVal(self.detail_Data_Dict["createdAt"]) as? String ?? ""
                          }else {
                               time = DataManager.getVal(self.detail_Data_Dict["orderDate"]) as? String ?? ""
                          }
                          
                          
                          
                          if let unixTime = Double(time) {
                                  let date = Date(timeIntervalSince1970: unixTime)
                                  let dateFormatter = DateFormatter()
                                  let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
                                  dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
                                  dateFormatter.locale = NSLocale.current
                                  dateFormatter.dateFormat = "dd MMM yyyy" //Specify your format that you want
                                 self.pidLbl.text = dateFormatter.string(from: date)
                              }
                          
                          self.rnLbl.text = DataManager.getVal(self.detail_Data_Dict["RxNumber"]) as? String ?? ""
                          
                          self.dqapidataLbl.text = DataManager.getVal(self.detail_Data_Dict["pharmaQuantity"]) as? String ?? ""
                          self.dqdetailapiDataLbl.text = DataManager.getVal(self.detail_Data_Dict["description"]) as? String ?? ""
                          if self.tabType == "Pending"{
                              self.titleLbl.text = typeName
                              self.titleLbl.textColor = Config().AppButtonOrangeColor
                              self.PriceLbl.text = "$ 0.00"
                          }else if self.tabType == "Active"{
                              let refill = Int(DataManager.getVal(self.detail_Data_Dict["refill"]) as? String ?? "")
                              
                              if refill == 0 {
                                  self.showRefillLbl.isHidden = true
                                  self.refillButton.isHidden = true
                              }else{
                                  self.showRefillLbl.isHidden = false
                                  self.refillButton.isHidden = false
                              }
                              
                              self.titleLbl.text = typeName
                              self.titleLbl.textColor = Config().AppGreenColor
                              self.dpLbl.text = fullName
                              self.doctor_Notes.text = pharmaNotes
                              let formulationName = DataManager.getVal(self.detail_Data_Dict["recommendedFormulation"]) as? String ?? ""
                              self.DosagesformLbl.text = formulationName
                              let format = DataManager.getVal(self.detail_Data_Dict["format"]) as? String ?? ""
                              self.StrengthLbl.text = format
                              let route = DataManager.getVal(self.detail_Data_Dict["route"]) as? String ?? ""
                              self.RouteLbl.text = route
                              
                          }else if self.tabType == "InProcess"{
                              self.titleLbl.text = typeName
                              self.titleLbl.textColor = Config().AppYellowColor
                              let formulationName = DataManager.getVal(self.detail_Data_Dict["recommendedFormulation"]) as? String ?? ""
                              self.DosagesformLbl.text = formulationName
                              let format = DataManager.getVal(self.detail_Data_Dict["format"]) as? String ?? ""
                              self.StrengthLbl.text = format
                              let route = DataManager.getVal(self.detail_Data_Dict["route"]) as? String ?? ""
                              self.RouteLbl.text = route
                          }else{
                              self.titleLbl.text = typeName
                              self.titleLbl.textColor = Config().AppGrayColor
                          }
                          
      //                    if self.tabType == "InProcess" {
      //                    self.PriceLbl.text = "$\(pricePerPec).00"
      //                    }else{
      //                    self.PriceLbl.text = "$ 0.00"
      //                    }
                          self.PaymentTblView.reloadData()
                          self.paymentSelect_AAPI()
                      }else{
                          Config().error(message: message)
                      }
                  }
                  self.clearHud()
              }
          }
       @objc func CheckButtonAction(_ sender: UIButton){
           SelectValue = sender.tag
          // self.PaymentTblView.reloadData()
      
       }
       
       func PendingTap_API(){
               let parameterDictionary = NSMutableDictionary()
               if selectty == "Single" {
                   parameterDictionary.setValue(DataManager.getVal(str_id), forKey: "id")
                   parameterDictionary.setValue(DataManager.getVal("true"), forKey: "status")
                   parameterDictionary.setValue(DataManager.getVal(""), forKey: "prescribableName")
                   parameterDictionary.setValue(DataManager.getVal(""), forKey: "labeller")
                   parameterDictionary.setValue(DataManager.getVal(self.productBatchPrice.text), forKey: "totalPrice")
                   parameterDictionary.setValue(DataManager.getVal(self.taxlbl), forKey: "substituteTax")
               }else {
                   parameterDictionary.setValue(DataManager.getVal(str_id), forKey: "id")
                   parameterDictionary.setValue(DataManager.getVal("true"), forKey: "status")
                   parameterDictionary.setValue(DataManager.getVal(self.priscrinametxt), forKey: "prescribableName")
                   parameterDictionary.setValue(DataManager.getVal(self.priscribelabellerr), forKey: "labeller")
                   parameterDictionary.setValue(DataManager.getVal(self.pricetotal), forKey: "totalPrice")
                   parameterDictionary.setValue(DataManager.getVal(self.taxlbl), forKey: "substituteTax")
        }
               print(parameterDictionary)
               
               let methodName = "/updateStatus"
               
               getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
                   if error == nil{
                       let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                       let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                       
                       if success == "1"{
                           
                       }else{
                           Config().error(message: message)
                       }
                      
                   }
               }
           }
           
       
       
    @IBAction func bachBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
       func paymentSelect_AAPI(){
           
           let prescName = DataManager.getVal(self.detail_Data_Dict["prescName"]) as? String ?? ""
           
           self.showHud()
           let parameterDictionary = NSMutableDictionary()
           parameterDictionary.setValue(DataManager.getVal(prescName), forKey: "prescName")
           print(parameterDictionary)
           
           let methodName = "/getPrice"
           
           getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
               if error == nil{
                   let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                   let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                   DispatchQueue.main.async {
                       if success == "1"{
                           
                           self.data_Array = DataManager.getVal(responseData?.object(forKey: "data")) as? [Any] ?? []
                           print(self.data_Array)
                           var array:NSMutableArray!
                           array = NSMutableArray(array: self.data_Array)
                           self.mecArray = array.value(forKey: "medicineBatch") as? NSArray
                           //self.PaymentTblView.reloadData()
                           
                       }else{
                           Config().error(message: message)
                       }
                       
                   }
                   self.clearHud()
               }
           }

       }
       
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return subtituteProduct.count
           }
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableCell", for: indexPath) as! PaymentTableCell
               let data = DataManager.getVal(self.subtituteProduct[indexPath.row]) as! NSDictionary
              // mecArray = data.object(forKey: "medicineBatch") as? NSArray
               //print(mecArray!)
              // let data1 = DataManager.getVal(self.mecArray.lastObject) as! NSDictionary
              // let detail_data = DataManager.getVal(data["medicineBatch"]) as! NSDictionary
               let prscName = DataManager.getVal(data["medicineName"]) as? String ?? ""
               let price = DataManager.getVal(data["subtitutePrice"]) as? String ?? ""
               var pridata:Int!
               pridata = Int(price)
               var totalprdata:Int!
               totalprdata = self.prscribeamount*pridata
               var newtlprice:String!
               newtlprice = String(totalprdata)
               self.itemPrice.append(price)
               let defaults = UserDefaults.standard
               defaults.set(mecArray, forKey: "price")
               defaults.synchronize()
               cell.price.text = "$\(newtlprice ?? "0").00"
               cell.prscName.text = prscName
               cell.btn_check.tag = indexPath.row
               
               if self.tabType == "InProcess" {
                   let pricePerPec = DataManager.getVal(self.detail_Data_Dict["pricePerPec"]) as? String ?? ""
                   cell.price.text = "$\(pricePerPec).00"
                   cell.prscName.text = prscName
                   cell.btn_check.isHidden = true
                   
               }
               
               if self.buttonCounter.contains(indexPath.row){
                   cell.btn_check.setImage(UIImage(named:"GreenRadioButtonActive"), for: .normal)
               }else{
                   cell.btn_check.setImage(UIImage(named:"GREEN_UNCHECK"), for: .normal)
               }
               
       //        if self.buttonCounter.contains(indexPath.row){
       //            cell.btn_check.setImage(UIImage(named:"GreenRadioButtonActive"), for: .normal)
       //        }else{
       //            cell.btn_check.setImage(UIImage(named:"GREEN_UNCHECK"), for: .normal)
       //        }
       //
       //
               return cell
           }
           func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableCell", for: indexPath) as! PaymentTableCell
              // let data = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
               let data = DataManager.getVal(self.subtituteProduct[indexPath.row]) as! NSDictionary
               //mecArray = data.object(forKey: "medicineBatch") as? NSArray
              // let data1 = DataManager.getVal(self.mecArray.lastObject) as! NSDictionary
               let price = DataManager.getVal(data["subtitutePrice"]) as? String ?? ""
               let pricetax = DataManager.getVal(data["substituteTax"]) as? String ?? ""
               let sublabller = DataManager.getVal(data["substituteLabeller"]) as? String ?? ""
               let medname = DataManager.getVal(data["medicineName"]) as? String ?? ""
               var pridata:Int!
               pridata = Int(price)
               var totalprdata:Int!
               totalprdata = self.prscribeamount*pridata
               var newtlprice:String!
               newtlprice = String(totalprdata)
               let defaults = UserDefaults.standard
               defaults.set(newtlprice, forKey: "PRICE")
               defaults.synchronize()
               
               if self.buttonCounter.contains(indexPath.row){
                   self.buttonCounter.remove(indexPath.row)
                   self.PriceLbl.text = "$ 0.00"
               }else{
                   self.buttonCounter.removeAllObjects()
                   self.buttonCounter.add(indexPath.row)
                   self.PriceLbl.text = "$\(newtlprice ?? "0").00"
                   self.checkBtnNew.setImage(UIImage(named: "GREEN_UNCHECK"), for: .normal)
                   self.selectty = "Double"
                   self.priscribelabellerr = sublabller
                   self.taxlbl = pricetax
                   self.pricetotal = newtlprice
                   self.priscrinametxt = medname
                   
               }
               self.PaymentTblView.reloadData()
               
       //        if self.buttonCounter.contains(indexPath.row){
       //            self.buttonCounter.remove(indexPath.row)
       //            self.PriceLbl.text = "$ 0.00"
       //            print(self.buttonCounter)
       //            self.PaymentTblView.reloadData()
       //
       //
       //        }else{
       //            self.buttonCounter.add(indexPath.row)
       //            self.PriceLbl.text = "$\(newtlprice ?? "0").00"
       //            print(self.buttonCounter)
       //            self.checkBtnNew.setImage(UIImage(named: "GREEN_UNCHECK"), for: .normal)
       //            self.PaymentTblView.reloadData()
       //
       //        }
           }
       
       @IBAction func btn_DisplayDrugList(_ sender: UIButton) {
           btn_DisplayDrugList.isSelected = !btn_DisplayDrugList.isSelected
           
           if btn_DisplayDrugList.isSelected == true {
               UIView.animate(withDuration: 0, animations: {
                   if sender.transform == .identity {
                       sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.999))
                   } else {
                       sender.transform = .identity
                   }
               })
               self.detailView.isHidden = true
               constarint_height_drugdetailsView.constant = 0
              // constarint_height_drugsList.constant = 391

           }else {
               UIView.animate(withDuration: 0, animations: {
                   if sender.transform == .identity {
                       sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.999))
                   } else {
                       sender.transform = .identity
                   }
               })
               self.detailView.isHidden = false
               constarint_height_drugdetailsView.constant = 134
              // constarint_height_drugsList.constant = 132

           }
       }
       
       
       @IBAction func MoredetailBtnAction(_ sender: UIButton) {
            more_detailBtn.isSelected = !more_detailBtn.isSelected
           if more_detailBtn.isSelected == true {
               UIView.animate(withDuration: 0, animations: {
                   if sender.transform == .identity {
                       sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.999))
                   } else {
                       sender.transform = .identity
                   }
               })
               self.moredetailview.isHidden = true
               constraint_height_detailView.constant = 0
              // constarint_height_drugsList.constant = 344
               
           }else{
               UIView.animate(withDuration: 0, animations: {
                   if sender.transform == .identity {
                       sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.999))
                   } else {
                       sender.transform = .identity
                   }
               })
               self.moredetailview.isHidden = false
               constraint_height_detailView.constant = 270
               //constarint_height_drugsList.constant = 132
           }
       }
       
       
       @IBAction func btn_DisplayTabletDetails(_ sender: UIButton) {
           
           btn_Presciption_Details.isSelected = !btn_Presciption_Details.isSelected
           
           if btn_Presciption_Details.isSelected == true {
               UIView.animate(withDuration: 0, animations: {
                   if sender.transform == .identity {
                       sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.999))
                   } else {
                       sender.transform = .identity
                   }
               })
               self.prescriptionDetailView.isHidden = true
               constarint_height_prescriptionView.constant = 0
              // constarint_height_drugsList.constant = 344
               
           }else{
               UIView.animate(withDuration: 0, animations: {
                   if sender.transform == .identity {
                       sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.999))
                   } else {
                       sender.transform = .identity
                   }
               })
               self.prescriptionDetailView.isHidden = false
               constarint_height_prescriptionView.constant = 255
              // constarint_height_drugsList.constant = 132
           }
           
       }
       
   }

