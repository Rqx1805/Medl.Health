//
//  TabletDetailVC.swift
//  Medl
//
//  Created by mac-15 on 24/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class Stat {
   var statEvents : [StatEvents] = []
}

struct StatEvents {
   var id: String
   var price: String
}


class TabletDetailVC: BaseBackViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var PaymentTblView: UITableView!
    var str_id = String()
    
    @IBOutlet weak var RxImage: UIImageView!
    @IBOutlet weak var PriceView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var prescriptionDetailView: UIView!
    
    var DetailButtonFlag = Bool()
    var tabType = String()
    
    @IBOutlet weak var subtitudeLbl: UILabel!
    @IBOutlet weak var subtituteHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    var prinNew:String!
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
    @IBOutlet weak var RefillCheckButton: ResponsiveButton!
    @IBOutlet weak var lbl_AutomaticallyRefillPrescription: UILabel!
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
    
    @IBOutlet weak var AmountView: UIView!
    @IBOutlet weak var amountHeightConstantView: NSLayoutConstraint!
    
    @IBOutlet weak var moredetailview: UIView!
    
    @IBOutlet weak var pnLbl: UILabel!
    var pricebatch:Int!
    var pricebatch1:Int!
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
    var subtituteProduct = [Any]()
    var detail_Data_Dict = [String: Any]()
    var doctor_data_dict:[String: Any]!
    var Pharma_data_dict:[String: Any]!
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
    var printFlat:String!
    @IBOutlet weak var productbatchName: UILabel!
    @IBOutlet weak var productBatchPrice: UILabel!
    @IBOutlet weak var checkBtnNew: UIButton!
    @IBOutlet weak var checkBtnNew1: UIButton!
    var priscribelabellerr:String!
    var pricetotal:String!
    var priscrinametxt:String!
    var taxlbl:String!
    var selectty:String!
    var isclick: Bool = false
    var prnewAr = NSMutableArray()
    var finalprar = NSMutableArray()
    var TaxAr = NSMutableArray()
    var qaunt:String!
    var tlprnew:String!
    var subRoute:String!
    var subDosage:String!
    var subdrug:String!
    var subProduct:String!
    var substrenth:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemId.append(str_id)
        self.doctor_Notes.layer.borderColor = Config().AppGrayColor.cgColor
        self.doctor_Notes.layer.borderWidth = 1.0
        self.moredetailview.isHidden = true
        constraint_height_detailView.constant = 0
        self.prescriptionDetailView.isHidden = true
        constarint_height_prescriptionView.constant = 0
        constarint_height_drugsList.constant = 344
        self.detailView.isHidden = false
        constarint_height_drugdetailsView.constant = 160
        constarint_height_drugsList.constant = 132
//        self.img_tablet.layer.cornerRadius = 3
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
            self.DeclineButtonOutlet.isHidden = true
            self.ConfirmButtonOutlet.isHidden = true
            self.PaymentTblView.isHidden = false
            self.BackView.shadowRadius = 2
            self.BackView.layer.shadowOpacity = 2
            self.BackView.layer.shadowOffset = .init(width: 2, height: 2)
            self.DeclineButton.isHidden = false
            self.ConfirmButton.isHidden = false
        }else{
            self.DeclineButtonOutlet.isHidden = true
            self.ConfirmButtonOutlet.isHidden = true
            self.PaymentTblView.isHidden = true
            self.BackView.shadowRadius = 0
            self.BackView.layer.shadowOpacity = 0
            self.BackView.layer.shadowOffset = .init(width: 0, height: 0)
            self.DeclineButton.isHidden = true
            self.ConfirmButton.isHidden = true
        }
        
        let nibClass = UINib(nibName: "PaymentTableCell", bundle: nil)
        self.PaymentTblView.register(nibClass, forCellReuseIdentifier: "PaymentTableCell")
        self.PaymentTblView.estimatedRowHeight = 60
        self.PaymentTblView.rowHeight = UITableView.automaticDimension
        self.PaymentTblView.dataSource = self
        self.PaymentTblView.delegate = self
        self.PaymentTblView.tableFooterView = UIView()
        self.PaymentTblView.sectionHeaderHeight = 0
        self.PaymentTblView.separatorStyle = .none
        
        
      
        self.viewPrescriptionsDetail_API()
        
        if self.tabType == "InProcess"{
            self.dqtitlelbl.isHidden = true
            self.dqapidataLbl.isHidden = true
            self.dqdetailapiDataLbl.isHidden = true
            self.dpTitleLbl.isHidden = true
            self.dpLbl.isHidden = true
            self.DeclineButton.isHidden = true
            self.ConfirmButton.isHidden = true
            self.RxImage.image = UIImage(named: "Group 4")
            self.img_tablet.image = UIImage(named: "App Icon")
            self.img_tablet.isHidden = false
            self.PriceView.backgroundColor = Config().AppGreenColor
            self.DeclineButtonOutlet.isHidden = true
            self.ConfirmButtonOutlet.isHidden = true
            self.constraint_view_bottom.constant = 150
            self.PaymentTblView.isHidden = true
            self.constarint_height_drugsList.constant = 0
            self.subtitudeLbl.isHidden = true
            self.subtituteHeightConstant.constant = 0
            self.PriceView.isHidden = true
            self.btn_DisplayDrugList.isHidden = false
            self.scrollView.isScrollEnabled = true
            self.PaymentTblView.isScrollEnabled = false
            self.predateTitleLbl.text = "PRESCRIPTION ISSUE DATE"
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
            self.img_tablet.image = UIImage(named: "App Icon")
            self.PriceView.backgroundColor = Config().AppGreenColor
            self.scrollView.isScrollEnabled = true
            self.img_tablet.isHidden = false
            self.detailView.isHidden = false
            self.PaymentTblView.isHidden = false
            self.dqtitlelbl.isHidden = true
            self.dqapidataLbl.isHidden = true
            self.dqdetailapiDataLbl.isHidden = true
            self.dpTitleLbl.isHidden = true
            self.dpLbl.isHidden = true
            self.subtitudeLbl.isHidden = false
            self.subtituteHeightConstant.constant = 22
            self.predateTitleLbl.text = "PRESCRIPTION ISSUE DATE"
        }else if self.tabType == "Active"{
            self.DeclineButton.isHidden = true
            self.ConfirmButton.isHidden = true
            self.RxImage.image = UIImage(named: "Group 2")
            self.img_tablet.image = UIImage(named: "App Icon")
              self.img_tablet.isHidden = false
           // self.PaymentTblView.isHidden = true
            self.predateTitleLbl.text = "PRESCRIPTION FILL DATE"
            self.scrollView.isScrollEnabled = true
            self.PriceView.isHidden = true
          //  self.subtitudeLbl.isHidden = true
           // self.subtituteHeightConstant.constant = 0
            self.PriceView.backgroundColor = Config().AppGreenColor
            refillButton.backgroundColor = Config().AppNavBlueColor
            refillButton.setTitle("REFILL", for: .normal)
            refillButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            refillButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
            refillButton.titleLabel?.numberOfLines = 2
            refillButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            refillButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            refillButton.addTarget(self, action: #selector(RefillActionButton(_:)), for: .touchUpInside)
            self.scrollView.addSubview(refillButton)
            refillButton.translatesAutoresizingMaskIntoConstraints = false
            refillButton.layer.cornerRadius = 20
            refillButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            refillButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
            refillButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 135).isActive = true
            refillButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
            self.dqtitlelbl.isHidden = false
            self.dqapidataLbl.isHidden = false
            self.dqdetailapiDataLbl.isHidden = false
            self.dpTitleLbl.isHidden = false
            self.dpLbl.isHidden = false
        }else{
            self.RxImage.image = UIImage(named: "Group 14")
            self.PriceView.isHidden = true
            //self.PriceView.backgroundColor = Config().AppGreenColor
            self.predateTitleLbl.text = "PRESCRIPTION ISSUE DATE"
            self.ConfirmButton.isHidden = true
            self.DeclineButton.isHidden = true
            if printFlat == "1" {
                self.refillButton.isHidden = true
                self.AmountView.isHidden = true
                self.amountHeightConstantView.constant = 0
                
                self.dqtitlelbl.isHidden = true
                self.dqapidataLbl.isHidden = true
                self.dqdetailapiDataLbl.isHidden = true
                self.dpTitleLbl.isHidden = true
                self.dpLbl.isHidden = true
                self.img_tablet.image = UIImage(named: "App Icon")
                self.img_tablet.isHidden = false
            }else {
               self.dqtitlelbl.isHidden = false
               self.dqapidataLbl.isHidden = false
               self.dqdetailapiDataLbl.isHidden = false
               self.dpTitleLbl.isHidden = false
               self.dpLbl.isHidden = false
               self.img_tablet.image = UIImage(named: "App Icon")
                self.img_tablet.isHidden = false
                self.refillButton.isHidden = false
                refillButton.backgroundColor = Config().AppNavBlueColor
                refillButton.setTitle("REFILL", for: .normal)
                refillButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                refillButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
                refillButton.titleLabel?.numberOfLines = 2
                refillButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
                refillButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                refillButton.addTarget(self, action: #selector(RefillActionButton(_:)), for: .touchUpInside)
                self.scrollView.addSubview(refillButton)
                refillButton.translatesAutoresizingMaskIntoConstraints = false
                refillButton.layer.cornerRadius = 20
                refillButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
                refillButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
                refillButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 135).isActive = true
                refillButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
                self.AmountView.isHidden = false
                self.amountHeightConstantView.constant = 50
            }
            
        }
            DeclineButton.backgroundColor = UIColor.darkGray
            DeclineButton.setTitle(" DECLINE ORDER", for: .normal)
            DeclineButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
            DeclineButton.titleLabel?.numberOfLines = 2
            DeclineButton.titleLabel?.textAlignment = .center
            DeclineButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            DeclineButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            DeclineButton.addTarget(self, action: #selector(DeclinePurchaseButtonAction(_:)), for: .touchUpInside)
            self.view.addSubview(DeclineButton)
            DeclineButton.translatesAutoresizingMaskIntoConstraints = false
            DeclineButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
            DeclineButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
           // DeclineButton.layer.borderColor = UIColor.systemGray.cgColor
           // DeclineButton.layer.borderWidth = 1
            DeclineButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
            DeclineButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
            ConfirmButton.backgroundColor = UIColor(red: 83/255, green: 172/255, blue: 144/255, alpha: 1)
            ConfirmButton.setTitle(" CONFIRM ORDER", for: .normal)
            ConfirmButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
            ConfirmButton.titleLabel?.numberOfLines = 2
            ConfirmButton.titleLabel?.textAlignment = .center
            ConfirmButton.addTarget(self, action: #selector(ConfirmPurchaseButtonAction(_:)), for: .touchUpInside)
            self.view.addSubview(ConfirmButton)
            ConfirmButton.translatesAutoresizingMaskIntoConstraints = false
            ConfirmButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
            ConfirmButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
           // ConfirmButton.layer.borderColor = UIColor.systemGray.cgColor
           // ConfirmButton.layer.borderWidth = 1
            ConfirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
            ConfirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        
        
       
        
        
//        SocketIoManager.sharedInstance.establishConnection()
    }
    
    @objc func RefillActionButton(_ sender: UIButton){
        if buttonCounter.count == 0 && isclick == false {
            Config().error(message: "Please select medication")
        }else {
          let nextview = RefillView.intitiateFromNib()
          let model = BackModel()
          nextview.buttonDonehandler = {
              let vc = EnterYourAddressVC(nibName: "EnterYourAddressVC", bundle: nil)
              self.DetailButtonFlag = true
              vc.DetailButtonFlag = self.DetailButtonFlag
              vc.tabType = "Active"
              vc.idarray = self.itemId as? NSArray
              vc.pricearray = self.itemPrice as? NSArray
              vc.typeArray = self.itemRefill as? NSArray
              vc.TaxAr = self.TaxAr
              vc.finalprar = self.finalprar
              vc.prnewAr = self.prnewAr
              self.onlyPushViewController(vc)
              model.closewithAnimation()
              
          }
          nextview.buttonCancelhandler = {
              model.closewithAnimation()
          }
          model.show(view: nextview)
        }
    }
    
     @objc func DeclinePurchaseButtonAction(_ sender: UIButton) {
        
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
    @IBAction func checkBtnNewAction(_ sender: Any) {
        if (!isclick){
             checkBtnNew.setImage(UIImage(named: "GreenRadioButtonActive"), for: .normal)
             self.buttonCounter.removeAllObjects()
             self.PaymentTblView.reloadData()
             self.selectty = "Single"
             isclick=true
             if self.tabType == "Active"{
                var prnew:Int!
                   prnew = Int(tlprnew)
                   var TlNew:Float!
                   TlNew = Float(prnew!)
                   let TL = String(format: "%.02f",TlNew)
                   self.prnewAr.add(TlNew!)
                
                   let txnew = Int(taxlbl)
                   var newtxl =  Int()
                   if txnew == nil {
                    newtxl = 0
                   }else{
                    newtxl = txnew!
                  }
                   var TaxNew:Float!
                TaxNew = Float(newtxl)
                   let Tax = String(format: "%.02f",TaxNew)
                   
                
                   var costamonut:Int!
                   costamonut = prnew!*newtxl/100
                   var costnew:Float!
                   costnew = Float(costamonut!)
                   let cons = String(format: "%.02f",costnew)
                   self.TaxAr.add(costnew!)
                   var value:Int!
                   value = costamonut + prnew
                   var costn:Float!
                   costn = Float(value!)
                   let consn = String(format: "%.02f",costn)
                 //  self.finalprar.add(value!)
                
                   var newtl:Int!
                   newtl = Int(qaunt)
                   var tlnew:Int!
                   tlnew = newtl*self.pricebatch
                   var tlnk:Float!
                   tlnk = Float(tlnew!)
                   let newonetl = String(format: "%.02f",tlnk)
                   
                   var finaldata:Int!
                   finaldata = tlnew + costamonut
                   var finl:Float!
                   finl = Float(finaldata!)
                   let finlone = String(format: "%.02f",finl)
                   self.finalprar.add(finl!)
                   let defaults = UserDefaults.standard
                   
                   defaults.set(newonetl, forKey: "TLDATA1")
                   defaults.set(self.pricebatch, forKey: "UNITDATA1")
                   defaults.set(cons, forKey: "TAXDATA1")
                   defaults.set(finlone, forKey: "FINALDATA1")
                   defaults.set(qaunt, forKey: "QUANTITYDATA1")
                   defaults.set(self.productbatchName.text, forKey: "MEDNAME1")
                defaults.set("", forKey: "MEDNAME")
                defaults.set("", forKey: "SUBROUTE")
                defaults.set("", forKey: "SUBSTRENGTH")
                defaults.set("", forKey: "SUBPRODUCT")
                defaults.set("", forKey: "SUBDOSAGE")
                defaults.set("", forKey: "SUBDRUG")
                   defaults.set("NORPRO", forKey: "SUBP")
                   defaults.synchronize()
             }else {
                   var prnew:Int!
                   prnew = Int(tlprnew)
                   var TlNew:Float!
                   TlNew = Float(prnew!)
                   let TL = String(format: "%.02f",TlNew)
                   self.prnewAr.add(TlNew!)
                
                   let txnew = Int(taxlbl)
                   var newtxl =  Int()
                   if txnew == nil {
                    newtxl = 0
                   }else{
                    newtxl = txnew!
                  }
                   var TaxNew:Float!
                  TaxNew = Float(newtxl)
                   let Tax = String(format: "%.02f",TaxNew)
                   
                
                   var costamonut:Int!
                   costamonut = prnew!*newtxl/100
                   var costnew:Float!
                   costnew = Float(costamonut!)
                   let cons = String(format: "%.02f",costnew)
                   self.TaxAr.add(costnew!)
                   var value:Int!
                   value = costamonut + prnew
                   var costn:Float!
                   costn = Float(value!)
                   let consn = String(format: "%.02f",costn)
                   self.finalprar.add(costn!)
                
                   var newtl:Int!
                   newtl = Int(qaunt)
                   var tlnew:Int!
                   tlnew = newtl*self.pricebatch
                   var tlnk:Float!
                   tlnk = Float(tlnew!)
                   let newonetl = String(format: "%.02f",tlnk)
                   
                   var finaldata:Int!
                   finaldata = tlnew + costamonut
                   var finl:Float!
                   finl = Float(finaldata!)
                   let finlone = String(format: "%.02f",finl)
                   let defaults = UserDefaults.standard
                   self.finalprar.add(finl!)
                   defaults.set(newonetl, forKey: "TLDATA1")
                   defaults.set(self.pricebatch, forKey: "UNITDATA1")
                   defaults.set(cons, forKey: "TAXDATA1")
                   defaults.set(finlone, forKey: "FINALDATA1")
                   defaults.set(qaunt, forKey: "QUANTITYDATA1")
                   defaults.set(self.productbatchName.text, forKey: "MEDNAME1")
                defaults.set("", forKey: "MEDNAME")
                defaults.set("", forKey: "SUBROUTE")
                defaults.set("", forKey: "SUBSTRENGTH")
                defaults.set("", forKey: "SUBPRODUCT")
                defaults.set("", forKey: "SUBDOSAGE")
                defaults.set("", forKey: "SUBDRUG")
                   defaults.set("NORPRO", forKey: "SUBP")
                   defaults.synchronize()
            }
               
        }
        else
        {
            checkBtnNew.setImage(UIImage(named: "GREEN_UNCHECK"), for: .normal)
            isclick=false
           
        }
//        self.buttonCounter.removeAllObjects()
//        self.PaymentTblView.reloadData()
//        self.checkBtnNew.setImage(UIImage(named: "GreenRadioButtonActive"), for: .normal)
//        self.selectty = "Single"
        
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
        if buttonCounter.count == 0 && isclick == false {
            Config().error(message: "Please select medication")
        }
        else {
            let defaults = UserDefaults.standard
            defaults.set("Array", forKey: "NewData")
            defaults.set("Data", forKey: "DataShow")
            defaults.synchronize()
            self.PendingTap_API()
        }
        
//        if isclick == false {
//           // Config().error(message: "Please enter medicine")
//        }else {
//            let defaults = UserDefaults.standard
//            defaults.set("Array", forKey: "NewData")
//            defaults.synchronize()
//            self.PendingTap_API()
//            NotificationCenter.default.post(name: NSNotification.Name("APICALL"), object: nil)
//            navigationController?.popViewController(animated: true)
//         }
       
    
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
                    let Subroute = DataManager.getVal(self.detail_Data_Dict["subRoute"]) as? String ?? ""
                    let Substrength = DataManager.getVal(self.detail_Data_Dict["subStrength"]) as? String ?? "---"
                    let SubdosageForm = DataManager.getVal(self.detail_Data_Dict["subDosageForm"]) as? String ?? ""
                    let Subprodut = DataManager.getVal(self.detail_Data_Dict["subsituteProduct"]) as? String ?? ""
                    let allowsubSts = DataManager.getVal(self.detail_Data_Dict["allowSubstitutes"]) as? String ?? ""
                    let prscribeamount1 = DataManager.getVal(self.detail_Data_Dict["prescribedAmount"]) as? String ?? ""
                    self.qaunt = prscribeamount1
                    let productName = DataManager.getVal(self.detail_Data_Dict["typeName"]) as? String ?? ""
                   
                    
                  //  self.productbatchName.text = productName
                    if self.tabType == "Pending" {
                          self.prscribeamount = Int(prscribeamount1)
                    }else if self.tabType == "Active" {
                          self.prscribeamount = Int(prscribeamount1)
                    }else if self.tabType == "InProcess" {
                          self.prscribeamount = 0
                    }else {
                        if self.printFlat == "1" {
                             self.prscribeamount = 0
                        }else {
                             self.prscribeamount = Int(prscribeamount1)
                        }
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
                             let productNamenew = DataManager.getVal(data1["prescribableName"]) as? String ?? ""
                            self.prinNew = productNamenew
                            if taxper == "" {
                                self.taxlbl = "0.00"
                            }else {
                                self.taxlbl = taxper
                            }
                            
                            self.subtituteProduct = DataManager.getVal(data1["substituteProduct"]) as? [Any] ?? []
                            if self.tabType == "Pending" {
                            if self.subtituteProduct.count == 0 {
                                self.constarint_height_drugsList.constant = 0
                                self.PaymentTblView.isHidden = true
                                self.subtitudeLbl.isHidden = true
                                self.subtituteHeightConstant.constant = 0
                            }else {
                                
                                self.constarint_height_drugsList.constant = 171
                                self.PaymentTblView.isHidden = false
                                self.subtitudeLbl.isHidden = false
                                self.subtituteHeightConstant.constant = 22
            
                            }
                            }else  if self.tabType == "Active" {
//                                self.constarint_height_drugsList.constant = 171
//                                self.PaymentTblView.isHidden = false
//                                self.subtitudeLbl.isHidden = false
//                                self.subtituteHeightConstant.constant = 22
                                
                            }else  if self.tabType == "InProcess" {
                                self.constarint_height_drugsList.constant = 0
                                self.PaymentTblView.isHidden = true
                                self.subtitudeLbl.isHidden = true
                                self.subtituteHeightConstant.constant = 0
                            }else {
                                self.constarint_height_drugsList.constant = 0
                                self.PaymentTblView.isHidden = true
                                self.subtitudeLbl.isHidden = true
                                self.subtituteHeightConstant.constant = 0
                                
                            }
                            self.medBatchArray = DataManager.getVal(data1["medicineBatch"]) as! NSArray
                            let dictnew = self.medBatchArray.lastObject as? NSDictionary
                           
                            self.pricebatch = dictnew!.value(forKey: "price") as? Int
                            var pricetotal:Int!
                            pricetotal = self.prscribeamount*self.pricebatch
                            self.tlprnew = String(pricetotal)
                            self.productBatchPrice.text = "$\(String(pricetotal) ?? "0").00"
                           print(Subprodut)
                            
                            if Subprodut == nil || Subprodut == "" {
                                self.RouteLbl.text = route
                                self.StrengthLbl.text = strength
                                self.DosagesformLbl.text = dosageForm
                            }else{
                                self.RouteLbl.text = Subroute
                                self.StrengthLbl.text = Substrength
                                self.DosagesformLbl.text = SubdosageForm
                            }
                           

                        }
                    }
                    
                    
                    if self.tabType == "Pending" {
                        self.AmountView.isHidden = false
                        self.amountHeightConstantView.constant = 50
                    }else if self.tabType == "Active" {
                         self.AmountView.isHidden = false
                          self.amountHeightConstantView.constant = 50
                    }else if self.tabType == "InProcess" {
                          self.AmountView.isHidden = true
                          self.amountHeightConstantView.constant = 0
                    }else {
                        if self.printFlat == "1" {
                            self.AmountView.isHidden = true
                            self.amountHeightConstantView.constant = 0
                            self.refillButton.isHidden = true
                           // self.predateTitleLbl.text = "PRESCRIPTION ISSUE DATE"
                        }else {
                            self.AmountView.isHidden = false
                            self.amountHeightConstantView.constant = 50
                            self.refillButton.isHidden = false
                           // self.predateTitleLbl.text = "PRESCRIPTION ISSUE DATE"
                          

                        }
                       
                    }
                    self.doctor_data_dict = DataManager.getVal(self.detail_Data_Dict["doctorId"]) as? [String: Any]
                    self.Pharma_data_dict = DataManager.getVal(self.detail_Data_Dict["pharmaId"]) as? [String: Any]
                    var fullName:String!
                    var firstName:String!
                    var lastName:String!
                    if self.Pharma_data_dict == nil {
                        if self.doctor_data_dict == nil {
                            fullName =  ""
                        }else {
                            fullName = DataManager.getVal(self.doctor_data_dict["fullName"]) as? String ?? ""
                        }
                        
                    }else {
                        fullName = DataManager.getVal(self.Pharma_data_dict["fullName"]) as? String ?? ""
                    }
                    if self.doctor_data_dict == nil {
                       firstName = ""
                       lastName = ""
                    }else {
                         firstName = DataManager.getVal(self.doctor_data_dict["firstName"]) as? String ?? ""
                         lastName = DataManager.getVal(self.doctor_data_dict["lastName"]) as? String ?? ""
                    }
                    
                   
                    
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
                    self.DrNameLbl.text = "Dr. \(firstName.capitalizingFirstLetter() + " " + lastName)"
//                    self.titleLbl.text = typeName
//                    self.titleLbl.text = "\(formulationName): \(typeName)"
                    self.DurationLbl.text = (duration + ("  \(schedule)"))
                    let frtype = DataManager.getVal(self.detail_Data_Dict["frequencyType"]) as? String ?? ""
                    self.FrequencyLbl.text = frequency + "X " + frtype
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
                         time = DataManager.getVal(self.detail_Data_Dict["createdAt"]) as? String ?? ""
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
                        if Subprodut == nil || Subprodut == "" {
                          self.titleLbl.text = self.prinNew
                         }else {
                            self.titleLbl.text = Subprodut
                            
                        }
                        if allowsubSts == "1" {
                           self.constarint_height_drugsList.constant = 171
                           self.PaymentTblView.isHidden = false
                           self.subtitudeLbl.isHidden = false
                           self.subtituteHeightConstant.constant = 22
                       }else {
                           self.subtitudeLbl.isHidden = true
                           self.subtituteHeightConstant.constant = 0
                           self.constarint_height_drugsList.constant = 0
                           self.PaymentTblView.isHidden = true
                       }
                        
                       // self.titleLbl.text = self.prinNew
                        self.productbatchName.text = self.prinNew
                        self.titleLbl.textColor = Config().AppButtonOrangeColor
                        self.PriceLbl.text = "$ 0.00"
                        
                        if (!self.isclick){
                        self.checkBtnNew.setImage(UIImage(named: "GreenRadioButtonActive"), for: .normal)
                                self.buttonCounter.removeAllObjects()
                                self.PaymentTblView.reloadData()
                                self.selectty = "Single"
                        self.isclick=true
                                if self.tabType == "Active"{
                                   var prnew:Int!
                                    prnew = Int(self.tlprnew)
                                      var TlNew:Float!
                                      TlNew = Float(prnew!)
                                      let TL = String(format: "%.02f",TlNew)
                                      self.prnewAr.add(TlNew!)
                                   
                                    let txnew = Int(self.taxlbl)
                                      var newtxl =  Int()
                                      if txnew == nil {
                                       newtxl = 0
                                      }else{
                                       newtxl = txnew!
                                     }
                                      var TaxNew:Float!
                                   TaxNew = Float(newtxl)
                                      let Tax = String(format: "%.02f",TaxNew)
                                      
                                   
                                      var costamonut:Int!
                                      costamonut = prnew!*newtxl/100
                                      var costnew:Float!
                                      costnew = Float(costamonut!)
                                      let cons = String(format: "%.02f",costnew)
                                      self.TaxAr.add(costnew!)
                                      var value:Int!
                                      value = costamonut + prnew
                                      var costn:Float!
                                      costn = Float(value!)
                                      let consn = String(format: "%.02f",costn)
                                    //  self.finalprar.add(value!)
                                   
                                      var newtl:Int!
                                    newtl = Int(self.qaunt)
                                      var tlnew:Int!
                                      tlnew = newtl*self.pricebatch
                                      var tlnk:Float!
                                      tlnk = Float(tlnew!)
                                      let newonetl = String(format: "%.02f",tlnk)
                                      
                                      var finaldata:Int!
                                      finaldata = tlnew + costamonut
                                      var finl:Float!
                                      finl = Float(finaldata!)
                                      let finlone = String(format: "%.02f",finl)
                                      self.finalprar.add(finl!)
                                      let defaults = UserDefaults.standard
                                      
                                      defaults.set(newonetl, forKey: "TLDATA1")
                                      defaults.set(self.pricebatch, forKey: "UNITDATA1")
                                      defaults.set(cons, forKey: "TAXDATA1")
                                      defaults.set(finlone, forKey: "FINALDATA1")
                                    defaults.set(self.qaunt, forKey: "QUANTITYDATA1")
                                    defaults.set(self.productbatchName.text, forKey: "MEDNAME1")
                                    defaults.set("", forKey: "MEDNAME")
                                    defaults.set("", forKey: "SUBROUTE")
                                    defaults.set("", forKey: "SUBSTRENGTH")
                                    defaults.set("", forKey: "SUBPRODUCT")
                                    defaults.set("", forKey: "SUBDOSAGE")
                                    defaults.set("", forKey: "SUBDRUG")
                                      defaults.set("NORPRO", forKey: "SUBP")
                                      defaults.synchronize()
                                }else {
                                      var prnew:Int!
                                    prnew = Int(self.tlprnew)
                                      var TlNew:Float!
                                      TlNew = Float(prnew!)
                                      let TL = String(format: "%.02f",TlNew)
                                      self.prnewAr.add(TlNew!)
                                   
                                    let txnew = Int(self.taxlbl)
                                      var newtxl =  Int()
                                      if txnew == nil {
                                       newtxl = 0
                                      }else{
                                       newtxl = txnew!
                                     }
                                      var TaxNew:Float!
                                     TaxNew = Float(newtxl)
                                      let Tax = String(format: "%.02f",TaxNew)
                                      
                                   
                                      var costamonut:Int!
                                      costamonut = prnew!*newtxl/100
                                      var costnew:Float!
                                      costnew = Float(costamonut!)
                                      let cons = String(format: "%.02f",costnew)
                                      self.TaxAr.add(costnew!)
                                      var value:Int!
                                      value = costamonut + prnew
                                      var costn:Float!
                                      costn = Float(value!)
                                      let consn = String(format: "%.02f",costn)
                                      self.finalprar.add(costn!)
                                   
                                      var newtl:Int!
                                    newtl = Int(self.qaunt)
                                      var tlnew:Int!
                                      tlnew = newtl*self.pricebatch
                                      var tlnk:Float!
                                      tlnk = Float(tlnew!)
                                      let newonetl = String(format: "%.02f",tlnk)
                                      
                                      var finaldata:Int!
                                      finaldata = tlnew + costamonut
                                      var finl:Float!
                                      finl = Float(finaldata!)
                                      let finlone = String(format: "%.02f",finl)
                                      let defaults = UserDefaults.standard
                                      self.finalprar.add(finl!)
                                      defaults.set(newonetl, forKey: "TLDATA1")
                                      defaults.set(self.pricebatch, forKey: "UNITDATA1")
                                      defaults.set(cons, forKey: "TAXDATA1")
                                      defaults.set(finlone, forKey: "FINALDATA1")
                                      defaults.set(self.qaunt, forKey: "QUANTITYDATA1")
                                      defaults.set(self.productbatchName.text, forKey: "MEDNAME1")
                                    defaults.set("", forKey: "MEDNAME")
                                    defaults.set("", forKey: "SUBROUTE")
                                    defaults.set("", forKey: "SUBSTRENGTH")
                                    defaults.set("", forKey: "SUBPRODUCT")
                                    defaults.set("", forKey: "SUBDOSAGE")
                                    defaults.set("", forKey: "SUBDRUG")
                                      defaults.set("NORPRO", forKey: "SUBP")
                                      defaults.synchronize()
                               }
                                  
                           }else {
                               
                           }
                        
                    }else if self.tabType == "Active"{
                        let refill = Int(DataManager.getVal(self.detail_Data_Dict["refill"]) as? String ?? "")
                        
                        if refill == 0 {
                            self.showRefillLbl.isHidden = true
                            self.refillButton.isHidden = true
                            self.checkBtnNew1.isUserInteractionEnabled = false
                            self.subtitudeLbl.isHidden = true
                            self.subtituteHeightConstant.constant = 0
                            self.PaymentTblView.isHidden = true
                            self.constarint_height_drugsList.constant = 0
                            self.AmountView.isHidden = true
                            self.amountHeightConstantView.constant = 0
                            
                        }else{
                            self.showRefillLbl.isHidden = false
                            self.refillButton.isHidden = false
                            self.checkBtnNew1.isUserInteractionEnabled = true
                          //  self.subtitudeLbl.isHidden = false
                           // self.subtituteHeightConstant.constant = 22
                           // self.PaymentTblView.isHidden = false
                          //  self.constarint_height_drugsList.constant = 171
                            self.AmountView.isHidden = false
                            self.amountHeightConstantView.constant = 50
                            
                            if allowsubSts == "1" {
                                self.constarint_height_drugsList.constant = 171
                                self.PaymentTblView.isHidden = false
                                self.subtitudeLbl.isHidden = false
                                self.subtituteHeightConstant.constant = 22
                            }else {
                                self.subtitudeLbl.isHidden = true
                                self.subtituteHeightConstant.constant = 0
                                self.constarint_height_drugsList.constant = 0
                                self.PaymentTblView.isHidden = true
                            }
                            
                        }
                        if Subprodut == nil || Subprodut == "" {
                         self.titleLbl.text = self.prinNew
                        }else {
                           self.titleLbl.text = Subprodut
                           
                       }
                        //self.titleLbl.text = self.prinNew
                        self.productbatchName.text = self.prinNew
                        self.titleLbl.textColor = Config().AppGreenColor
                        self.dpLbl.text = fullName
                        self.doctor_Notes.text = pharmaNotes
                        let formulationName = DataManager.getVal(self.detail_Data_Dict["recommendedFormulation"]) as? String ?? ""
                       // self.DosagesformLbl.text = formulationName
                        let format = DataManager.getVal(self.detail_Data_Dict["format"]) as? String ?? ""
                       // self.StrengthLbl.text = format
                        let route = DataManager.getVal(self.detail_Data_Dict["route"]) as? String ?? ""
                       // self.RouteLbl.text = route
                        
                        if Subprodut == nil || Subprodut == "" {
                             self.RouteLbl.text = route
                             self.StrengthLbl.text = format
                             self.DosagesformLbl.text = formulationName
                         }else{
                             self.RouteLbl.text = Subroute
                             self.StrengthLbl.text = Substrength
                             self.DosagesformLbl.text = SubdosageForm
                         }
                        
                        if (!self.isclick){
                            self.checkBtnNew.setImage(UIImage(named: "GreenRadioButtonActive"), for: .normal)
                                    self.buttonCounter.removeAllObjects()
                                    self.PaymentTblView.reloadData()
                                    self.selectty = "Single"
                            self.isclick=true
                                    if self.tabType == "Active"{
                                       var prnew:Int!
                                        prnew = Int(self.tlprnew)
                                          var TlNew:Float!
                                          TlNew = Float(prnew!)
                                          let TL = String(format: "%.02f",TlNew)
                                          self.prnewAr.add(TlNew!)
                                       
                                        let txnew = Int(self.taxlbl)
                                          var newtxl =  Int()
                                          if txnew == nil {
                                           newtxl = 0
                                          }else{
                                           newtxl = txnew!
                                         }
                                          var TaxNew:Float!
                                       TaxNew = Float(newtxl)
                                          let Tax = String(format: "%.02f",TaxNew)
                                          
                                       
                                          var costamonut:Int!
                                          costamonut = prnew!*newtxl/100
                                          var costnew:Float!
                                          costnew = Float(costamonut!)
                                          let cons = String(format: "%.02f",costnew)
                                          self.TaxAr.add(costnew!)
                                          var value:Int!
                                          value = costamonut + prnew
                                          var costn:Float!
                                          costn = Float(value!)
                                          let consn = String(format: "%.02f",costn)
                                        //  self.finalprar.add(value!)
                                       
                                          var newtl:Int!
                                        newtl = Int(self.qaunt)
                                          var tlnew:Int!
                                          tlnew = newtl*self.pricebatch
                                          var tlnk:Float!
                                          tlnk = Float(tlnew!)
                                          let newonetl = String(format: "%.02f",tlnk)
                                          
                                          var finaldata:Int!
                                          finaldata = tlnew + costamonut
                                          var finl:Float!
                                          finl = Float(finaldata!)
                                          let finlone = String(format: "%.02f",finl)
                                          self.finalprar.add(finl!)
                                          let defaults = UserDefaults.standard
                                          
                                          defaults.set(newonetl, forKey: "TLDATA1")
                                          defaults.set(self.pricebatch, forKey: "UNITDATA1")
                                          defaults.set(cons, forKey: "TAXDATA1")
                                          defaults.set(finlone, forKey: "FINALDATA1")
                                          defaults.set(self.qaunt, forKey: "QUANTITYDATA1")
                                          defaults.set(self.productbatchName.text, forKey: "MEDNAME1")
                                        defaults.set("", forKey: "MEDNAME")
                                        defaults.set("", forKey: "SUBROUTE")
                                        defaults.set("", forKey: "SUBSTRENGTH")
                                        defaults.set("", forKey: "SUBPRODUCT")
                                        defaults.set("", forKey: "SUBDOSAGE")
                                        defaults.set("", forKey: "SUBDRUG")
                                          defaults.set("NORPRO", forKey: "SUBP")
                                          defaults.synchronize()
                                    }else {
                                          var prnew:Int!
                                        prnew = Int(self.tlprnew)
                                          var TlNew:Float!
                                          TlNew = Float(prnew!)
                                          let TL = String(format: "%.02f",TlNew)
                                          self.prnewAr.add(TlNew!)
                                       
                                        let txnew = Int(self.taxlbl)
                                          var newtxl =  Int()
                                          if txnew == nil {
                                           newtxl = 0
                                          }else{
                                           newtxl = txnew!
                                         }
                                          var TaxNew:Float!
                                         TaxNew = Float(newtxl)
                                          let Tax = String(format: "%.02f",TaxNew)
                                          
                                       
                                          var costamonut:Int!
                                          costamonut = prnew!*newtxl/100
                                          var costnew:Float!
                                          costnew = Float(costamonut!)
                                          let cons = String(format: "%.02f",costnew)
                                          self.TaxAr.add(costnew!)
                                          var value:Int!
                                          value = costamonut + prnew
                                          var costn:Float!
                                          costn = Float(value!)
                                          let consn = String(format: "%.02f",costn)
                                          self.finalprar.add(costn!)
                                       
                                          var newtl:Int!
                                        newtl = Int(self.qaunt)
                                          var tlnew:Int!
                                          tlnew = newtl*self.pricebatch
                                          var tlnk:Float!
                                          tlnk = Float(tlnew!)
                                          let newonetl = String(format: "%.02f",tlnk)
                                          
                                          var finaldata:Int!
                                          finaldata = tlnew + costamonut
                                          var finl:Float!
                                          finl = Float(finaldata!)
                                          let finlone = String(format: "%.02f",finl)
                                          let defaults = UserDefaults.standard
                                          self.finalprar.add(finl!)
                                          defaults.set(newonetl, forKey: "TLDATA1")
                                          defaults.set(self.pricebatch, forKey: "UNITDATA1")
                                          defaults.set(cons, forKey: "TAXDATA1")
                                          defaults.set(finlone, forKey: "FINALDATA1")
                                        defaults.set(self.qaunt, forKey: "QUANTITYDATA1")
                                        defaults.set(self.productbatchName.text, forKey: "MEDNAME1")
                                        defaults.set("", forKey: "MEDNAME")
                                        defaults.set("", forKey: "SUBROUTE")
                                        defaults.set("", forKey: "SUBSTRENGTH")
                                        defaults.set("", forKey: "SUBPRODUCT")
                                        defaults.set("", forKey: "SUBDOSAGE")
                                        defaults.set("", forKey: "SUBDRUG")
                                          defaults.set("NORPRO", forKey: "SUBP")
                                          defaults.synchronize()
                                   }
                                      
                               }else {
                                   
                               }
                               
                        
                        
                    }else if self.tabType == "InProcess"{
                         if Subprodut == nil || Subprodut == "" {
                          self.titleLbl.text = self.prinNew
                         }else {
                            self.titleLbl.text = Subprodut
                            
                        }
                        self.titleLbl.textColor = Config().AppYellowColor
                        let formulationName = DataManager.getVal(self.detail_Data_Dict["recommendedFormulation"]) as? String ?? ""
                      //  self.DosagesformLbl.text = formulationName
                        let format = DataManager.getVal(self.detail_Data_Dict["format"]) as? String ?? ""
                      //  self.StrengthLbl.text = format
                        let route = DataManager.getVal(self.detail_Data_Dict["route"]) as? String ?? ""
                       // self.RouteLbl.text = route
                        
                        if Subprodut == nil || Subprodut == "" {
                            self.RouteLbl.text = route
                            self.StrengthLbl.text = format
                            self.DosagesformLbl.text = formulationName
                        }else{
                            self.RouteLbl.text = Subroute
                            self.StrengthLbl.text = Substrength
                            self.DosagesformLbl.text = SubdosageForm
                        }
                    }else{
                        
                        if let unixTime = Double(time) {
                           let date = Date(timeIntervalSince1970: unixTime)
                           let dateFormatter = DateFormatter()
                           let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
                           dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
                           dateFormatter.locale = NSLocale.current
                           dateFormatter.dateFormat = "dd MMM yyyy" //Specify your format that you want
                          self.pidLbl.text = dateFormatter.string(from: date)
                       }
                        self.dqapidataLbl.text = DataManager.getVal(self.detail_Data_Dict["pharmaQuantity"]) as? String ?? ""
                        self.dqdetailapiDataLbl.text = DataManager.getVal(self.detail_Data_Dict["description"]) as? String ?? ""
                        self.productbatchName.text = self.prinNew
                        self.titleLbl.text = self.prinNew
                        self.dpLbl.text = fullName
                        self.doctor_Notes.text = pharmaNotes
                        self.titleLbl.textColor = Config().AppGrayColor
                        let refill = Int(DataManager.getVal(self.detail_Data_Dict["refill"]) as? String ?? "")
                        let ordersts = DataManager.getVal(self.detail_Data_Dict["orderStatus"]) as? String ?? ""
                        if refill == 0 {
                            if  ordersts == "Cancelled" {
                                self.showRefillLbl.text = "CANCELLED"
                                self.showRefillLbl.isHidden = false
                            }else {
                                 self.showRefillLbl.isHidden = true
                            }
                           // self.showRefillLbl.isHidden = true
                            self.refillButton.isHidden = true
                            self.checkBtnNew1.isUserInteractionEnabled = false
                            self.AmountView.isHidden = true
                            self.amountHeightConstantView.constant = 0
                        }else{
                            self.showRefillLbl.isHidden = false
                            self.refillButton.isHidden = false
                            self.checkBtnNew1.isUserInteractionEnabled = true
                            if self.printFlat == "1" {
                            self.showRefillLbl.text = "PRINTED"
                            self.AmountView.isHidden = true
                            self.amountHeightConstantView.constant = 0
                            }else {
                            self.showRefillLbl.text = "REFILL"
                            self.AmountView.isHidden = false
                            self.amountHeightConstantView.constant = 50
                            }
                        }
                        
                        
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
        self.PaymentTblView.reloadData()
   
    }
    
    func PendingTap_API(){
        let parameterDictionary = NSMutableDictionary()
        let price = self.productBatchPrice.text?.replacingOccurrences(of: "$", with: "")
        print(price!)
        if selectty == "Single" {
            parameterDictionary.setValue(DataManager.getVal(str_id), forKey: "id")
            parameterDictionary.setValue(DataManager.getVal("true"), forKey: "status")
            parameterDictionary.setValue(DataManager.getVal(""), forKey: "prescribableName")
            parameterDictionary.setValue(DataManager.getVal(""), forKey: "labeller")
            parameterDictionary.setValue(DataManager.getVal(price), forKey: "totalPrice")
            parameterDictionary.setValue(DataManager.getVal(self.pricebatch), forKey: "unitPrice")
            parameterDictionary.setValue(DataManager.getVal(self.taxlbl), forKey: "substituteTax")
            parameterDictionary.setValue(DataManager.getVal(self.subProduct), forKey: "subProductName")
            parameterDictionary.setValue(DataManager.getVal(self.subdrug), forKey: "subDrugName")
            parameterDictionary.setValue(DataManager.getVal(self.subDosage), forKey: "subDosageForm")
            parameterDictionary.setValue(DataManager.getVal(self.substrenth), forKey: "subStrength")
            parameterDictionary.setValue(DataManager.getVal(self.subRoute), forKey: "subRoute")
        }else {
            parameterDictionary.setValue(DataManager.getVal(str_id), forKey: "id")
            parameterDictionary.setValue(DataManager.getVal("true"), forKey: "status")
            parameterDictionary.setValue(DataManager.getVal(self.priscrinametxt), forKey: "prescribableName")
            parameterDictionary.setValue(DataManager.getVal(self.priscribelabellerr), forKey: "labeller")
            parameterDictionary.setValue(DataManager.getVal(self.pricetotal), forKey: "totalPrice")
            parameterDictionary.setValue(DataManager.getVal(self.taxlbl), forKey: "substituteTax")
            parameterDictionary.setValue(DataManager.getVal(self.pricebatch1), forKey: "unitPrice")
            parameterDictionary.setValue(DataManager.getVal(self.subProduct), forKey: "subProductName")
            parameterDictionary.setValue(DataManager.getVal(self.subdrug), forKey: "subDrugName")
            parameterDictionary.setValue(DataManager.getVal(self.subDosage), forKey: "subDosageForm")
            parameterDictionary.setValue(DataManager.getVal(self.substrenth), forKey: "subStrength")
            parameterDictionary.setValue(DataManager.getVal(self.subRoute), forKey: "subRoute")
        }
        
//        parameterDictionary.setValue(DataManager.getVal(str_id), forKey: "id")
//        parameterDictionary.setValue(DataManager.getVal("true"), forKey: "status")
//        parameterDictionary.setValue(DataManager.getVal("true"), forKey: "prescribableName")
//        parameterDictionary.setValue(DataManager.getVal("true"), forKey: "labeller")
//        parameterDictionary.setValue(DataManager.getVal("true"), forKey: "totalPrice")
//        parameterDictionary.setValue(DataManager.getVal("true"), forKey: "substituteTax")
        print(parameterDictionary)
        
        let methodName = "/updateStatus"
        
        getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
            if error == nil{
                let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                
                if success == "1"{
                    NotificationCenter.default.post(name: NSNotification.Name("APICALL"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }else{
                    Config().error(message: message)
                }
               
            }
        }
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
                        self.PaymentTblView.reloadData()
                        
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
        self.pricebatch1 = Int(price)
        let pricetax = DataManager.getVal(data["substituteTax"]) as? String ?? ""
        let sublabller = DataManager.getVal(data["substituteLabeller"]) as? String ?? ""
        let medname = DataManager.getVal(data["medicineName"]) as? String ?? ""
        self.subdrug =  DataManager.getVal(data["subDrugName"]) as? String ?? ""
        self.subProduct =  DataManager.getVal(data["subProductName"]) as? String ?? ""
        self.substrenth =  DataManager.getVal(data["subStrength"]) as? String ?? ""
        self.subDosage =  DataManager.getVal(data["subDosageForm"]) as? String ?? ""
        self.subRoute =  DataManager.getVal(data["subRoute"]) as? String ?? ""
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
            self.isclick = false
            self.selectty = "Double"
            self.priscribelabellerr = sublabller
            if pricetax == "" {
                  self.taxlbl = "0.00"
            }else {
                  self.taxlbl = pricetax
            }

            self.pricetotal = newtlprice
            self.priscrinametxt = medname
            
            
            var prnew:Int!
            prnew =  Int(price)
            var TlNew:Float!
            TlNew = Float(prnew!)
            let TL = String(format: "%.02f",TlNew)
            
            
            var cons:String!
            let txnew = Int(pricetax)
            self.prnewAr.add(TlNew)
            var TaxNew:Float!
            var vatne:String!
            var actitalpr:String!
            if txnew == nil {
                TaxNew = 0.00
                let Tax = String(format: "%.02f",TaxNew)
                self.TaxAr.add(Tax)
                var qwn:Float!
                qwn = Float(qaunt)
                var costamonut:Float!
                costamonut = TlNew!*qwn!
           //var costnew:Float!
          // costnew = Float(costamonut!)
            cons = String(format: "%.02f",costamonut)
              }else {
                 TaxNew = Float(txnew!)
                  let Tax = String(format: "%.02f",TaxNew)
                  var qwn:Float!
                  qwn = Float(qaunt)
                  var costamonut:Float!
                  costamonut = TlNew!*qwn!
                  actitalpr = String(format: "%.02f",costamonut)
                  var toltx:Float!
                  toltx = costamonut*TaxNew/100
                  self.TaxAr.add(toltx!)
                  vatne = String(format: "%.02f",toltx)
                  var value:Float!
                  value = costamonut + toltx
                  cons = String(format: "%.02f",value)
                  self.finalprar.add(value!)
              
             }
           
            
            //self.TaxAr.add(cons)
            //var costnew:Int!
           // costnew = Int(costamonut)
            
//            var costn:Float!
//            costn = Float(value!)
//            let consn = String(format: "%.02f",costn)
            

            let defaults = UserDefaults.standard
            defaults.set(TL, forKey: "TLDATA")
            defaults.set(vatne, forKey: "TAXDATA")
            defaults.set(cons, forKey: "FINALDATA")
            defaults.set(qaunt, forKey: "QUANTITYDATA")
            defaults.set(actitalpr, forKey: "AutualData")
            defaults.set(medname, forKey: "MEDNAME")
            defaults.set(self.subRoute, forKey: "SUBROUTE")
            defaults.set(self.substrenth, forKey: "SUBSTRENGTH")
            defaults.set(self.subProduct, forKey: "SUBPRODUCT")
            defaults.set(self.subDosage, forKey: "SUBDOSAGE")
            defaults.set(self.subdrug, forKey: "SUBDRUG")
            defaults.set(medname, forKey: "MEDNAME")
            defaults.set("SUBPRO", forKey: "SUBP")
            defaults.synchronize()
            
            

               
//               defaults.set(newonetl, forKey: "TLDATA")
//               defaults.set(self.pricebatch, forKey: "UNITDATA")
//               defaults.set(cons, forKey: "TAXDATA")
//               defaults.set(finlone, forKey: "FINALDATA")
//               defaults.set(qaunt, forKey: "QUANTITYDATA")
//               defaults.set(titleLbl.text, forKey: "MEDNAME")
//               defaults.synchronize()
            
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
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
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
            constarint_height_drugsList.constant = 391

        }else {
            UIView.animate(withDuration: 0, animations: {
                if sender.transform == .identity {
                    sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.999))
                } else {
                    sender.transform = .identity
                }
            })
            self.detailView.isHidden = false
            constarint_height_drugdetailsView.constant = 160
            constarint_height_drugsList.constant = 132

        }
    }
    
    
    @IBAction func MoredetailBtnAction(_ sender: UIButton) {
         more_detailBtn.isSelected = !more_detailBtn.isSelected
        if more_detailBtn.isSelected == false {
            UIView.animate(withDuration: 0, animations: {
                if sender.transform == .identity {
                    sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.999))
                } else {
                    sender.transform = .identity
                }
            })
            self.moredetailview.isHidden = true
            constraint_height_detailView.constant = 0
            constarint_height_drugsList.constant = 344
            
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
            constarint_height_drugsList.constant = 132
        }
    }
    
    
    @IBAction func btn_DisplayTabletDetails(_ sender: UIButton) {
        
        btn_Presciption_Details.isSelected = !btn_Presciption_Details.isSelected
        
        if btn_Presciption_Details.isSelected == false {
            UIView.animate(withDuration: 0, animations: {
                if sender.transform == .identity {
                    sender.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.999))
                } else {
                    sender.transform = .identity
                }
            })
            self.prescriptionDetailView.isHidden = true
            constarint_height_prescriptionView.constant = 0
            constarint_height_drugsList.constant = 344
            
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
            constarint_height_drugsList.constant = 132
        }
        
    }
    
}
