//
//  DashBoard.swift
//  Medl
//
//  Created by mac-15 on 23/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class DashBoard: BaseViewController, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var MenuCollectionView: UICollectionView!
    
    @IBOutlet weak var PendingtblView: UITableView!
    @IBOutlet weak var ActiveTblView: UITableView!
    @IBOutlet weak var InProgressTblView: UITableView!
    @IBOutlet weak var ExpireTblView: UITableView!
    
    //MARK:-ActiveHiddenView
    @IBOutlet var ActiveHiddenView: UIView!
    @IBOutlet weak var checkOutBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    var titleArray = ["PENDING","ACTIVE","IN PROCESS","EXPIRED"]
    
    fileprivate var selectedCell: Int = 0
    var defaults:UserDefaults!
    var status:Int!
    
    var data_Array = [Any]()
    var refillExpireAt = String()
    var StatusMesasge = "1"
    var ns = NSMutableArray()
    var pendingRefreshControl: UIRefreshControl!
    var inProcessRefreshControl: UIRefreshControl!
    var activeRefreshControl: UIRefreshControl!
    var expireRefreshControl: UIRefreshControl!
    var apiStatus = String()
    var select_type_array = [String]()
    var select_type_arrayNew:[String]!
    var lastSelectedIndexPath = NSIndexPath(row: -1, section: 0)
    var checkout = UIButton()
    var parachute = UIButton()
    var my_lbl = UILabel()
    var prcPrice = String()
    var selctionData:String!
    var myData = [String: Any]()
    var itemArr = [[String: Any]]()
    var selectedArray = [Any]()
    var nsnewArray = NSMutableArray()
    var nsnewArray1 = NSMutableArray()
    var idar:NSArray!
    var prar:NSArray!
    var nsmuta = NSMutableArray()
    var idnew:String!
    var appsts:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults = UserDefaults.standard
        defaults.removeObject(forKey: "PRICE")
        defaults.removeObject(forKey: "Arrayprice")
        defaults.removeObject(forKey: "Arrayid")
        nsnewArray.removeAllObjects()
        nsnewArray1.removeAllObjects()
        nsmuta.removeAllObjects()
        appsts = "pending"
        self.checkOutBtn.isHidden = false
        self.imgView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvert1(_:)), name: NSNotification.Name("APICALL"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvertNew(_:)), name: NSNotification.Name("SocketOnEvent"), object: nil)
        
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvert5(_:)), name: NSNotification.Name("APICALLNEW"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvert6(_:)), name: NSNotification.Name("APICALLNEWONE"), object: nil)
        
        
        
        
        DispatchQueue.main.async {
            self.showHud()
            self.DashBoard_API(status: "Pending")
            self.PendingtblView.reloadData()
            self.clearHud()
            //self.checkout.isHidden = true
        }
        
        DispatchQueue.main.async {
        if #available(iOS 10.0, *) {
            self.pendingRefreshControl = UIRefreshControl()
            self.pendingRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            self.pendingRefreshControl.addTarget(self,action: #selector(self.refreshPending),for: .valueChanged)
            self.PendingtblView.addSubview(self.pendingRefreshControl)
        }
        if #available(iOS 10.0, *) {
            self.inProcessRefreshControl = UIRefreshControl()
            self.inProcessRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            self.inProcessRefreshControl.addTarget(self,action: #selector(self.refreshInProcess),for: .valueChanged)
            self.InProgressTblView.addSubview(self.inProcessRefreshControl)
        }
        if #available(iOS 10.0, *) {
            self.activeRefreshControl = UIRefreshControl()
            self.activeRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            self.activeRefreshControl.addTarget(self,action: #selector(self.refreshActive),for: .valueChanged)
            self.ActiveTblView.addSubview(self.activeRefreshControl)
        }
        if #available(iOS 10.0, *) {
            self.expireRefreshControl = UIRefreshControl()
            self.expireRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            self.expireRefreshControl.addTarget(self,action: #selector(self.refreshExpire),for: .valueChanged)
            self.ExpireTblView.addSubview(self.activeRefreshControl)
        }
    }
        
        let LiberaryLayOut1 = UICollectionViewFlowLayout()
        LiberaryLayOut1.itemSize = CGSize(width: 105, height: 50)
        LiberaryLayOut1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        LiberaryLayOut1.minimumInteritemSpacing = 0
        LiberaryLayOut1.minimumLineSpacing = 10
        LiberaryLayOut1.scrollDirection = .horizontal
        
        let LiberaryLayOutClassNearBy1 = UINib(nibName: "MenuCollectionCell", bundle: nil)
        self.MenuCollectionView.register(LiberaryLayOutClassNearBy1, forCellWithReuseIdentifier: "MenuCollectionCell")
        self.MenuCollectionView.collectionViewLayout = LiberaryLayOut1
        
        
        let Pending_nibClass = UINib(nibName: "PendingTableCell", bundle: nil)
        self.PendingtblView.register(Pending_nibClass, forCellReuseIdentifier: "PendingTableCell")
        self.PendingtblView.estimatedRowHeight = 60
        self.PendingtblView.rowHeight = UITableView.automaticDimension
        self.PendingtblView.dataSource = self
        self.PendingtblView.delegate = self
        self.PendingtblView.tableFooterView = UIView()
        self.PendingtblView.sectionHeaderHeight = 0
        self.PendingtblView.separatorStyle = .none
//        self.PendingtblView.addSubview(refreshControl)
        
        
        let nibClass = UINib(nibName: "ActiveTableCell", bundle: nil)
        self.ActiveTblView.register(nibClass, forCellReuseIdentifier: "ActiveTableCell")
        self.ActiveTblView.estimatedRowHeight = 60
        self.ActiveTblView.rowHeight = UITableView.automaticDimension
        self.ActiveTblView.dataSource = self
        self.ActiveTblView.delegate = self
        self.ActiveTblView.tableFooterView = UIView()
        self.ActiveTblView.sectionHeaderHeight = 0
        self.ActiveTblView.separatorStyle = .none
//        self.ActiveTblView.addSubview(refreshControl)
        
        let InProgressnibClass = UINib(nibName: "InProgressTableCell", bundle: nil)
        self.InProgressTblView.register(InProgressnibClass, forCellReuseIdentifier: "InProgressTableCell")
        self.InProgressTblView.estimatedRowHeight = 60
        self.InProgressTblView.rowHeight = UITableView.automaticDimension
        self.InProgressTblView.dataSource = self
        self.InProgressTblView.delegate = self
        self.InProgressTblView.tableFooterView = UIView()
        self.InProgressTblView.sectionHeaderHeight = 0
        self.InProgressTblView.separatorStyle = .none
//        self.InProgressTblView.addSubview(refreshControl)
        
        let ExpirenibClass = UINib(nibName: "ExpireTableCell", bundle: nil)
        self.ExpireTblView.register(ExpirenibClass, forCellReuseIdentifier: "ExpireTableCell")
        self.ExpireTblView.estimatedRowHeight = 60
        self.ExpireTblView.rowHeight = UITableView.automaticDimension
        self.ExpireTblView.dataSource = self
        self.ExpireTblView.delegate = self
        self.ExpireTblView.tableFooterView = UIView()
        self.ExpireTblView.sectionHeaderHeight = 0
        self.ExpireTblView.separatorStyle = .none
//        self.ExpireTblView.addSubview(refreshControl)
        
        self.ActiveHiddenView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        
       
        
        parachute.backgroundColor = Config().AppNavBlueColor
//        parachute.setImage(UIImage(named: "Group 4291"), for: .normal)
        parachute.setTitle("?", for: .normal)
        parachute.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        parachute.addTarget(self, action: #selector(parachuteAction), for: .touchUpInside)
        self.view.addSubview(parachute)
        parachute.translatesAutoresizingMaskIntoConstraints = false
        parachute.heightAnchor.constraint(equalToConstant: 44).isActive = true
        parachute.widthAnchor.constraint(equalToConstant: 44).isActive = true
//        parachute.layer.cornerRadius = 50 * parachute.frame.size.width/2
//        parachute.clipsToBounds = true
        self.roundCorners(cornerRadius: 22.0)
        parachute.layer.borderColor = UIColor.systemGray.cgColor
        parachute.layer.borderWidth = 0
        parachute.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35).isActive = true
//        parachute.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        parachute.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45).isActive = true
        
        my_lbl.text = "Medl Assist"
        my_lbl.textAlignment = .center
        my_lbl.tintColor = Config().AppNavBlueColor
        my_lbl.font = UIFont.systemFont(ofSize: 15)
        my_lbl.numberOfLines = 0
        my_lbl.layer.borderWidth = 1
        my_lbl.layer.borderColor = UIColor.white.cgColor
        my_lbl.layer.cornerRadius = 8.0
        my_lbl.layer.shadowColor = UIColor.lightGray.cgColor
        my_lbl.layer.shadowRadius = 5.0
        my_lbl.layer.shadowOpacity = 1.0
        my_lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        my_lbl.layer.masksToBounds = false
        my_lbl.backgroundColor = .white
        self.view.addSubview(my_lbl)
        my_lbl.translatesAutoresizingMaskIntoConstraints = false
        my_lbl.heightAnchor.constraint(equalToConstant: 22).isActive = true
        my_lbl.widthAnchor.constraint(equalToConstant: 85).isActive = true
        my_lbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        my_lbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        self.PendingtblView.isHidden = false
        self.ActiveTblView.isHidden = true
        self.InProgressTblView.isHidden = true
        self.ExpireTblView.isHidden = true
       // self.checkout.isHidden = true
        
//                checkout.backgroundColor = .systemGray
//                checkout.setTitle("CHECKOUT", for: .normal)
//                checkout.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//                self.view.addSubview(checkout)
//                checkout.translatesAutoresizingMaskIntoConstraints = false
//                checkout.heightAnchor.constraint(equalToConstant: 50).isActive = true
//                checkout.widthAnchor.constraint(equalToConstant: 140).isActive = true
//                checkout.layer.borderColor = UIColor.systemGray.cgColor
//                checkout.layer.borderWidth = 1
//                checkout.layer.cornerRadius = 3
//                checkout.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 115).isActive = true
//        //        checkout.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//                checkout.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//
        
        SocketIoManager.sharedInstance.establishConnection()
        
        
    }
    
    @objc func currencyConvert1(_ pNotification: Notification?) {
        self.DashBoard_API(status: "Pending")
       }
    
    @objc func currencyConvertNew(_ pNotification: Notification?) {
           self.DashBoard_API(status: "Pending")
        }
    
    @objc func currencyConvert5(_ pNotification: Notification?) {
        self.DashBoard_API(status: "Pending")
    }
    
    @objc func currencyConvert6(_ pNotification: Notification?) {
           self.DashBoard_API(status: "Pending")
       }
       
    @objc func currencyConvert3(_ pNotification: Notification?) {
     var dictmew = NSArray()
     dictmew = pNotification?.object as! NSArray
     var messgae:String!
     for i in 0..<dictmew.count {
     var dict = NSDictionary()
        dict = dictmew.object(at: i) as! NSDictionary
        messgae = dict.object(forKey: "message") as? String
     }
    
     let alert = UIAlertController(title: "", message: messgae, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
     self.present(alert, animated: true, completion: nil)
    }
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UserDefaults.standard.removeObject(forKey: "date")
        defaults = UserDefaults.standard
        prcPrice = defaults.value(forKey: "PRICE") as? String ?? ""
        selctionData = defaults.value(forKey: "NewData") as? String ?? ""
        print(prcPrice)
        nsnewArray1.add(prcPrice)
        defaults.set(nsnewArray1, forKey: "Arrayprice")
        
        if selectedCell != 0{
            print("Not Equal")
        }else{
        
        if selctionData == "Array" {
            
        }
        else {
            DispatchQueue.main.async {
//                self.showHud()
//                self.DashBoard_API(status: "Pending")
                self.select_type_array.removeAll()
//                self.clearHud()
            }
        }
        }
    }
    
    func roundCorners(cornerRadius: Double) {
        
        if #available(iOS 11.0, *) {
            
        parachute.layer.cornerRadius = CGFloat(cornerRadius)
        parachute.clipsToBounds = true
        parachute.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        }else{
            
        let path = UIBezierPath(roundedRect: parachute.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, . bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = parachute.bounds
        maskLayer.path = path.cgPath
        parachute.layer.mask = maskLayer
        
        }
        
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
      print("Button tapped")
       var DetailButtonFlag = Bool()
        select_type_arrayNew = defaults.array(forKey: "Array") as? [String]
        nsnewArray1.removeObject(at: 0)
        defaults.set(nsnewArray1, forKey: "Arrayprice")
        idar = defaults.array(forKey: "Arrayid") as NSArray?
        prar = defaults.array(forKey: "Arrayprice") as NSArray?
        
//        for i in 0..<idar.count {
//           // for j in 0..<prar.count {
//              var dictPaitient = [String:Any]()
//              var id:String!
//              id = idar.object(at: i) as? String
//              var price:String!
//              price = prar.object(at: i) as? String
//              dictPaitient = ["id": id!,
//                              "price": price!]
//             print(dictPaitient)
//             nsmuta.add(dictPaitient)
//           // }
//        }
//        print(nsmuta)
//        let  typeIdArrayString = self.JSONStringify(value: nsmuta as AnyObject)
//        print(typeIdArrayString)
        
//        SocketIoManager.sharedInstance.connectToServerWithRoom(nickname: typeIdArrayString)
//        SocketIoManager.sharedInstance.sendMessage(withSender: typeIdArrayString)

        let vc = EnterYourAddressVC(nibName: "EnterYourAddressVC", bundle: nil)
        DetailButtonFlag = true
        vc.DetailButtonFlag = DetailButtonFlag
        vc.tabType = "Pending"
        vc.idarray = idar
        vc.pricearray = prar
        self.onlyPushViewController(vc)
    }
    
    @objc func parachuteAction(sender: UIButton!) {
        
        let alertControl = UIAlertController(title: "Medl Assist", message: "Do you need assistance with your order?", preferredStyle: .alert)
               
               let action1 = UIAlertAction(title: "YES", style: .default) { (action:UIAlertAction) in
                let alertControl = UIAlertController(title: "Medl Assist", message: "Would you like a medl representative to call you to assist you with your order?", preferredStyle: .alert)
                
                let action1 = UIAlertAction(title: "YES", style: .default) { (action:UIAlertAction) in
                    let typeIdArrayString = self.defaults.value(forKey: "iduser")
                        
                        var dictPaitient = [String:Any]()
                        dictPaitient = ["type": "parachute","user_id": typeIdArrayString!]
                        
                        let typeIdArrayStringnew = self.JSONStringify(value: dictPaitient as AnyObject)
                        
                      //  SocketIoManager.sharedInstance.sendMessage(withSender: typeIdArrayStringnew)
                    SocketIoManager.sharedInstance.connectToServerWiththirdRoom(nickname: typeIdArrayStringnew)
                            NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvert3(_:)), name: NSNotification.Name("notificationNameStudentnew"), object: nil)
                        
                  }
                let action2 = UIAlertAction(title: "NO", style: .default) { (action:UIAlertAction) in
                }
                alertControl.addAction(action1)
                alertControl.addAction(action2)
                
                self.present(alertControl, animated: true, completion: nil)
                       
                 }
               let action2 = UIAlertAction(title: "NO", style: .default) { (action:UIAlertAction) in
               }
               alertControl.addAction(action1)
               alertControl.addAction(action2)
               
               self.present(alertControl, animated: true, completion: nil)
        
          print("Button tapped")
             defaults = UserDefaults.standard
       

        }
    
  
    
    

    @objc func refreshPending(sender: UIRefreshControl) {
       // Code to refresh table view
        self.PendingtblView.reloadData()
        self.pendingRefreshControl.endRefreshing()
        self.DashBoard_API(status: "Pending")
        self.clearHud()
    }
    @objc func refreshInProcess(sender: UIRefreshControl) {
       // Code to refresh table view
        self.InProgressTblView.reloadData()
        self.inProcessRefreshControl.endRefreshing()
        self.DashBoard_API(status: "InProcess")
        self.clearHud()
    }
    @objc func refreshActive(sender: UIRefreshControl) {
       // Code to refresh table view
        self.ActiveTblView.reloadData()
        self.activeRefreshControl.endRefreshing()
        self.DashBoard_API(status: "Active")
        self.clearHud()
    }
    @objc func refreshExpire(sender: UIRefreshControl) {
       // Code to refresh table view
        self.ExpireTblView.reloadData()
        self.expireRefreshControl.endRefreshing()
        self.DashBoard_API(status: "Expired")
        self.clearHud()
    }
    
    @objc func DashBoard_API(status: String){
        
        self.showHud()
        let parameterDictionary = NSMutableDictionary()
        print(parameterDictionary)
        
        let methodName = "/viewAllPrescription?prescriptionStatus=\(status)"
        
        getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
            if error == nil{
                let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                DispatchQueue.main.async {
                    if success == "1"{
                        
                        self.data_Array = DataManager.getVal(responseData?.object(forKey: "data")) as? [Any] ?? []
                        let appdata = DataManager.getVal(responseData?.object(forKey: "appdata")) as? String ?? ""
                        
                        if self.appsts == "pending" {
                            if appdata == "0" {
                                self.checkOutBtn.isHidden = true
                            }else {
                               self.checkOutBtn.isHidden = false
                            }
                        if self.data_Array.count == 0 {
                              self.parachute.isHidden = true
                              self.my_lbl.isHidden = true
                          }else {
                              self.parachute.isHidden = false
                              self.my_lbl.isHidden = false
                          }
                             self.PendingtblView.reloadData()
//                            if self.data_Array.count == 0 {
//                                  self.imgView.isHidden = false
//                                  self.imgView.image = UIImage(named: "NoPending")
//                                  self.PendingtblView.isHidden = true
//                                  self.PendingtblView.reloadData()
//                            }else {
//                                  self.imgView.isHidden = true
//                                  self.PendingtblView.isHidden = false
//                                  self.PendingtblView.reloadData()
//                            }
                            
                            
                        }else if self.appsts == "active" {
                              print("Active")
                              self.parachute.isHidden = true
//                              if self.data_Array.count == 0 {
//                                self.imgView.isHidden = false
//                                self.imgView.image = UIImage(named: "Active")
//                                self.ActiveTblView.isHidden = true
//                                self.ActiveTblView.reloadData()
//                              }else {
//                                  self.imgView.isHidden = true
//                                  self.ActiveTblView.isHidden = false
//                                  self.ActiveTblView.reloadData()
//                              }
                            self.ActiveTblView.reloadData()
                        }else if self.appsts == "inprocess" {
                              self.parachute.isHidden = true
                              print("Inprocess")
//                             if self.data_Array.count == 0 {
//                                   self.imgView.isHidden = false
//                                   self.imgView.image = UIImage(named: "InProgressBack")
//                                   self.InProgressTblView.isHidden = true
//                                   self.InProgressTblView.reloadData()
//                              }else {
//                                  self.imgView.isHidden = true
//                                  self.InProgressTblView.isHidden = false
//                                  self.InProgressTblView.reloadData()
//                              }
                            self.InProgressTblView.reloadData()
                        }else {
                            self.parachute.isHidden = true
                            print("Expire")
//                            if self.data_Array.count == 0 {
//                                self.imgView.isHidden = false
//                                self.imgView.image = UIImage(named: "NoExpiredPrescriptions")
//                                self.ExpireTblView.isHidden = true
//                                self.ExpireTblView.reloadData()
//                            }else {
//                                self.imgView.isHidden = true
//                                self.ExpireTblView.isHidden = false
//                                self.ExpireTblView.reloadData()
//                            }
                            self.ExpireTblView.reloadData()
                        }
                       
//                        self.PendingtblView.reloadData()
//                        self.ActiveTblView.reloadData()
//                        self.InProgressTblView.reloadData()
//                        self.ExpireTblView.reloadData()
                    }else{
                        Config().error(message: message)
                        self.checkOutBtn.isHidden = true
                        self.parachute.isHidden = true
                    }
                    
                }
                
                
                
                
                self.clearHud()
            }
        }
    }
    
    @IBAction func CancelButtonAction(_ sender: MyButton) {
        self.removeAnimate(YourHiddenView: self.ActiveHiddenView, ishidden: true)
    }
    @IBAction func YesButtonAction(_ sender: MyButton) {
        self.removeAnimate(YourHiddenView: self.ActiveHiddenView, ishidden: true)
        let vc = EnterYourAddressVC(nibName: "EnterYourAddressVC", bundle: nil)
        self.onlyPushViewController(vc)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionCell", for: indexPath) as! MenuCollectionCell
        cell.titleLbl.text = self.titleArray[indexPath.row]
        cell.tag = indexPath.row
        
        
        if indexPath.row == 0 {
            //cell.backgroundColor = Config().AppButtonOrangeColor
            cell.layer.borderColor = Config().AppButtonOrangeColor.cgColor
            cell.layer.borderWidth = 1.3
            cell.titleLbl.font = cell.titleLbl.font.withSize(16)
            cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.titleLbl.textColor = UIColor.gray
            cell.layer.cornerRadius = 4
            cell.clipsToBounds = true
            cell.layer.shadowColor = UIColor(red: 246/255, green: 109/255, blue: 4/255, alpha: 1.0).cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = .init(width: 2, height: 2)
            cell.layer.shadowRadius = 4
        }else if indexPath.row == 1{
            // cell.backgroundColor = Config().AppYellowColor
            cell.layer.borderColor = Config().AppGreenColor.cgColor
            cell.layer.borderWidth = 1.3
            cell.titleLbl.font = cell.titleLbl.font.withSize(16)
            cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.titleLbl.textColor = UIColor.gray
            cell.layer.cornerRadius = 4
            cell.clipsToBounds = true
            cell.layer.shadowColor = UIColor(red: 70/255, green: 189/255, blue: 198/255, alpha: 1.0).cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = .init(width: 2, height: 2)
            cell.layer.shadowRadius = 4
        }else if indexPath.row == 2{
            //cell.backgroundColor = Config().AppGreenColor
            cell.layer.borderColor = Config().AppYellowColor.cgColor
            cell.layer.borderWidth = 1.3
            cell.titleLbl.font = cell.titleLbl.font.withSize(16)
            cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.titleLbl.textColor = UIColor.gray
            cell.layer.cornerRadius = 4
            cell.clipsToBounds = true
            cell.layer.shadowColor = UIColor(red: 249/255, green: 188/255, blue: 5/255, alpha: 1.0).cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = .init(width: 2, height: 2)
            cell.layer.shadowRadius = 4
        }else {
            //cell.backgroundColor = Config().AppGrayColor
            cell.layer.borderColor = Config().AppGrayColor.cgColor
            cell.layer.borderWidth = 1.3
            cell.titleLbl.font = cell.titleLbl.font.withSize(16)
            cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.titleLbl.textColor = UIColor.gray
            cell.layer.cornerRadius = 4
            cell.clipsToBounds = true
            cell.layer.shadowColor = UIColor(red: 181/255, green: 181/255, blue: 181/255, alpha: 1.0).cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = .init(width: 2, height: 2)
            cell.layer.shadowRadius = 4
        }
        
        if selectedCell == 0 {
            if indexPath.row == 0 {
                cell.backgroundColor = Config().AppButtonOrangeColor
                cell.titleLbl.font = cell.titleLbl.font.withSize(16)
                cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
                cell.titleLbl.textColor = UIColor.white
            }else {
                cell.backgroundColor = Config().AppWhiteColor
            }
        }
        
        if selectedCell == 1 {
            if indexPath.row == 1 {
                cell.backgroundColor = Config().AppGreenColor
                cell.titleLbl.font = cell.titleLbl.font.withSize(16)
                cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
                cell.titleLbl.textColor = UIColor.white
            }else {
                cell.backgroundColor = Config().AppWhiteColor
            }
        }
        
        if selectedCell == 2 {
            if indexPath.row == 2 {
                cell.backgroundColor = Config().AppYellowColor
                cell.titleLbl.font = cell.titleLbl.font.withSize(16)
                cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
                cell.titleLbl.textColor = UIColor.white
            }else {
                cell.backgroundColor = Config().AppWhiteColor
            }
        }
        
        if selectedCell == 3 {
            if indexPath.row == 3 {
                cell.backgroundColor = Config().AppGrayColor
                cell.titleLbl.font = cell.titleLbl.font.withSize(16)
                cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
                cell.titleLbl.textColor = UIColor.white
            }else {
                cell.backgroundColor = Config().AppWhiteColor
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if selectedCell == indexPath.row{
            
            print("equal")
        
        }else{
        
        if indexPath.row == 0{
            self.StatusMesasge = "1"
            self.PendingtblView.isHidden = false
            self.ActiveTblView.isHidden = true
            self.InProgressTblView.isHidden = true
            self.ExpireTblView.isHidden = true
            self.parachute.isHidden = false
            self.my_lbl.isHidden = false
            self.checkOutBtn.isHidden = false
            self.appsts = "pending"
            DispatchQueue.main.async {
                self.DashBoard_API(status: "Pending")
            }
        }else if indexPath.row == 1{
            self.StatusMesasge = "3"
            self.PendingtblView.isHidden = true
            self.ActiveTblView.isHidden = false
            self.InProgressTblView.isHidden = true
            self.ExpireTblView.isHidden = true
            self.parachute.isHidden = true
            self.my_lbl.isHidden = true
            self.checkOutBtn.isHidden = true
            self.appsts = "active"
            DispatchQueue.main.async {
               self.DashBoard_API(status: "Active")
            }
        }else if indexPath.row == 2{
            self.StatusMesasge = "2"
            self.PendingtblView.isHidden = true
            self.ActiveTblView.isHidden = true
            self.InProgressTblView.isHidden = false
            self.ExpireTblView.isHidden = true
            self.parachute.isHidden = true
            self.my_lbl.isHidden = true
            self.checkOutBtn.isHidden = true
            self.appsts = "inprocess"
            DispatchQueue.main.async {
               self.DashBoard_API(status: "InProcess")
            }
        }else{
            self.StatusMesasge = "4"
            self.PendingtblView.isHidden = true
            self.ActiveTblView.isHidden = true
            self.InProgressTblView.isHidden = true
            self.ExpireTblView.isHidden = false
            self.parachute.isHidden = true
            self.my_lbl.isHidden = true
            self.checkOutBtn.isHidden = true
             self.appsts = "exipre"
            DispatchQueue.main.async {
               self.DashBoard_API(status: "Expired")
            }
        }
        }
        self.selectedCell = indexPath.row
        self.MenuCollectionView.reloadData()
        self.MenuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if (Config().shownIndexes.contains(indexPath) == false) {
//            Config().shownIndexes.append(indexPath)
//
//            cell.transform = CGAffineTransform(translationX: 0, y: Config().CELL_HEIGHT)
//            cell.layer.shadowColor = UIColor.black.cgColor
//            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
//            cell.alpha = 0
//
//            UIView.beginAnimations("rotation", context: nil)
//            UIView.setAnimationDuration(0.5)
//            cell.transform = CGAffineTransform(translationX: 0, y: 0)
//            cell.alpha = 1
//            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//            UIView.commitAnimations()
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.PendingtblView{
            if self.data_Array.count > 0{
                self.PendingtblView.backgroundView = nil
                self.PendingtblView.addSubview(pendingRefreshControl)
            }else{
                self.PendingtblView.backgroundView = UIImageView(image: UIImage(named: "NoPending"))
                
            }
            return self.data_Array.count
        }else if tableView == self.ActiveTblView{
            if self.data_Array.count > 0{
                self.ActiveTblView.backgroundView = nil
                self.ActiveTblView.addSubview(activeRefreshControl)
            }else{
                self.ActiveTblView.backgroundView = UIImageView(image: UIImage(named: "Active"))
                
                
            }
            return self.data_Array.count
        }else if tableView == InProgressTblView{
            if self.data_Array.count > 0{
                self.InProgressTblView.backgroundView = nil
                self.InProgressTblView.addSubview(inProcessRefreshControl)
            }else{
                self.InProgressTblView.backgroundView = UIImageView(image: UIImage(named: "InProgressBack"))
            }
            return self.data_Array.count
        }else{
            if self.data_Array.count > 0{
                self.ExpireTblView.backgroundView = nil
                self.ExpireTblView.addSubview(expireRefreshControl)
            }else{
                self.ExpireTblView.backgroundView = UIImageView(image: UIImage(named: "NoExpiredPrescriptions"))
            }
            return self.data_Array.count
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.PendingtblView{
           // self.checkOutBtn.isHidden = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "PendingTableCell", for: indexPath) as! PendingTableCell
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let doctor_dict = DataManager.getVal(dict["doctorId"]) as! NSDictionary
           // let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            let firstName = DataManager.getVal(doctor_dict["firstName"]) as? String ?? ""
            let lastName = DataManager.getVal(doctor_dict["lastName"]) as? String ?? ""
            let PrescName = DataManager.getVal(dict["prescName"]) as? String ?? ""
            let SubsituteProduct = DataManager.getVal(dict["subsituteProduct"]) as? String ?? ""
            if SubsituteProduct == "" {
                cell.titleNameLbl.text = PrescName.capitalizingFirstLetter()
            }else {
                cell.titleNameLbl.text = SubsituteProduct.capitalizingFirstLetter()
            }
           // cell.titleNameLbl.text = typeName.capitalizingFirstLetter()
            cell.issuedByLbl.text = "Dr. \(firstName.capitalizingFirstLetter() + " " + lastName)"
          //  self.checkout.tag = indexPath.row
            
            let sts = DataManager.getVal(dict["appStatus"]) as? String ?? ""
            
            if sts == "1" {
                cell.select_btn.setBackgroundImage(UIImage(named:"pendingcheck"), for: .normal)
              //  cell.select_btn.setImage(UIImage(named:"pendingcheck"), for: .normal)
                cell.select_btn.tag = indexPath.row
                cell.select_btn.addTarget(self, action: #selector(HandleTap(_:)), for: .touchUpInside)
                let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
                       let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
                       let cd = DataManager.getVal(dict["_id"])
                      
                               if select_type_array.contains(_id)
                               {
                                   ns.remove(cd)
                                   ns.remove(prcPrice)
                                   select_type_array.removeAll { $0 == _id }
                                   select_type_array.removeAll {$0 == prcPrice}
                                   nsnewArray.remove(cd)
                                   nsnewArray1.remove(prcPrice)
                                   let defaults = UserDefaults.standard
                                   defaults.set(self.ns, forKey: "Array")
                                   defaults.synchronize()

                               }
                               else
                               {
                                   select_type_array.append(_id)
                                   select_type_array.append(prcPrice)

                                   nsnewArray.add(cd)
                                   ns.add(cd)
                                   ns.add(prcPrice)
                                   let defaults = UserDefaults.standard
                                   defaults.set(self.ns, forKey: "Array")
                                   defaults.set(nsnewArray, forKey: "Arrayid")
                                   defaults.synchronize()


                               }
                               
                               
                           
            }else{
                cell.select_btn.tag = indexPath.row
                cell.select_btn.addTarget(self, action: #selector(HandleTap1(_:)), for: .touchUpInside)
                cell.select_btn.setBackgroundImage(UIImage(named:"Group 3"), for: .normal)
                //setImage(UIImage(named:"Group 3"), for: .normal)
            }
            
            return cell
        }else if tableView == self.ActiveTblView{
            
           // self.checkOutBtn.isHidden = true
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveTableCell", for: indexPath) as! ActiveTableCell
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            let PrescName = DataManager.getVal(dict["prescName"]) as? String ?? ""
            let SubsituteProduct = DataManager.getVal(dict["subsituteProduct"]) as? String ?? ""
            if let doctorId = DataManager.getVal(dict["doctorId"]) as? NSDictionary{
                let firstName = DataManager.getVal(doctorId["firstName"]) as? String ?? ""
                let lastName = DataManager.getVal(doctorId["lastName"]) as? String ?? ""
                
                let doctorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOne = NSMutableAttributedString(string: "Dr. ", attributes: doctorAttributes)
                let doctorTwo = NSMutableAttributedString(string: "\(firstName.capitalizingFirstLetter() + " " + lastName)", attributes: doctorOtherAttributes)
                let doctor_examcombination = NSMutableAttributedString()
                doctor_examcombination.append(doctorOne)
                doctor_examcombination.append(doctorTwo)
                cell.DoctorNameLbl.attributedText = doctor_examcombination
            }

            let refill = Int(DataManager.getVal(dict["refill"]) as? String ?? "")
//            let schedule = DataManager.getVal(dict["schedule"]) as? String ?? ""
            if refill == 0 {
                cell.refillsLbl.isHidden = true
            }else{
                cell.refillsLbl.isHidden = false
            }
            if SubsituteProduct == "" {
                cell.titleLbl.text = PrescName.capitalizingFirstLetter()
            }else {
                cell.titleLbl.text = SubsituteProduct.capitalizingFirstLetter()
            }
           // cell.titleLbl.text = typeName.capitalizingFirstLetter()
            
            return cell
            
        }else if tableView == InProgressTblView{
            
         //   self.checkOutBtn.isHidden = true
            let cell = tableView.dequeueReusableCell(withIdentifier: "InProgressTableCell", for: indexPath) as! InProgressTableCell
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            let PrescName = DataManager.getVal(dict["prescName"]) as? String ?? ""
            let SubsituteProduct = DataManager.getVal(dict["subsituteProduct"]) as? String ?? ""
            if let doctorId = DataManager.getVal(dict["doctorId"]) as? NSDictionary{
                let firstName = DataManager.getVal(doctorId["firstName"]) as? String ?? ""
                let lastName = DataManager.getVal(doctorId["lastName"]) as? String ?? ""
                
                let doctorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOne = NSMutableAttributedString(string: "Dr. ", attributes: doctorAttributes)
                let doctorTwo = NSMutableAttributedString(string: "\(firstName.capitalizingFirstLetter() + " " + lastName)", attributes: doctorOtherAttributes)
                let doctor_examcombination = NSMutableAttributedString()
                doctor_examcombination.append(doctorOne)
                doctor_examcombination.append(doctorTwo)
                cell.issuedByLbl.attributedText = doctor_examcombination
            }
            if SubsituteProduct == "" {
                cell.titleNameLbl.text = PrescName.capitalizingFirstLetter()
            }else {
                cell.titleNameLbl.text = SubsituteProduct.capitalizingFirstLetter()
            }
            
           // cell.titleNameLbl.text = typeName.capitalizingFirstLetter()
            
            return cell
            
        }else{
            
          //  self.checkOutBtn.isHidden = true
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpireTableCell", for: indexPath) as! ExpireTableCell
            
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let typeName = DataManager.getVal(dict["prescName"]) as? String ?? ""
            let recommendedFormulation = DataManager.getVal(dict["recommendedFormulation"]) as? String ?? ""
            
            let unit = DataManager.getVal(dict["unit"]) as? String ?? ""
            let route = DataManager.getVal(dict["route"]) as? String ?? ""
            let frequency = DataManager.getVal(dict["frequency"]) as? String ?? ""
            let duration = DataManager.getVal(dict["duration"]) as? String ?? ""
            let refill = DataManager.getVal(dict["refill"]) as? String ?? ""
            self.refillExpireAt = DataManager.getVal(dict["refillExpireAt"]) as? String ?? ""
            //let prescriptionId = DataManager.getVal(dict["prescriptionId"]) as? String ?? ""
            let prescriptionNumber = DataManager.getVal(dict["prescriptionNumber"]) as? String ?? ""
            let printFlag = DataManager.getVal(dict["printFlag"]) as? String ?? ""
            let orderStatus = DataManager.getVal(dict["orderStatus"]) as? String ?? ""
            if printFlag == "1" {
                cell.printLbl.text = "PRINTED"
            }else {
                 
                let refill = Int(DataManager.getVal(dict["refill"]) as? String ?? "")
                if refill == 0 {
                    if  orderStatus == "Cancelled" {
                       cell.printLbl.text = "CANCELLED"
                        cell.printLbl.isHidden = false
                    }else {
                        cell.printLbl.isHidden = true
                    }
                   // cell.printLbl.isHidden = true
                }else{
                    cell.printLbl.isHidden = false
                    cell.printLbl.text = "REFILL"
                }
            }
            
            
            cell.titleLbl.text = typeName.capitalizingFirstLetter()
           // cell.descLbl.text = recommendedFormulation
            
            let notes = DataManager.getVal(dict["notes"]) as? String ?? ""
            
            let notesAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let notesOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let notesOne = NSMutableAttributedString(string: "Notes  :  ", attributes: notesAttributes)
            let notesTwo = NSMutableAttributedString(string: "\(notes)", attributes: notesOtherAttributes)
            let notes_examcombination = NSMutableAttributedString()
            notes_examcombination.append(notesOne)
            notes_examcombination.append(notesTwo)
           // cell.NotesLbl.attributedText = notes_examcombination
            
            if let doctorId = DataManager.getVal(dict["doctorId"]) as? NSDictionary{
                let firstName = DataManager.getVal(doctorId["firstName"]) as? String ?? ""
                let lastName = DataManager.getVal(doctorId["lastName"]) as? String ?? ""
                
                let doctorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOne = NSMutableAttributedString(string: "Dr.  ", attributes: doctorAttributes)
                let doctorTwo = NSMutableAttributedString(string: "\(firstName.capitalizingFirstLetter() +  " " + lastName)", attributes: doctorOtherAttributes)
                let doctor_examcombination = NSMutableAttributedString()
                doctor_examcombination.append(doctorOne)
                doctor_examcombination.append(doctorTwo)
                cell.DoctorNameLbl.attributedText = doctor_examcombination
                
            }
            
            let unitAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let unitOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let unitOne = NSMutableAttributedString(string: "Quantity  :  ", attributes: unitAttributes)
            let unitTwo = NSMutableAttributedString(string: "\(unit)", attributes: unitOtherAttributes)
            let unit_examcombination = NSMutableAttributedString()
            unit_examcombination.append(unitOne)
            unit_examcombination.append(unitTwo)
          //  cell.quantityLbl.attributedText = unit_examcombination
            
            let routeAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let routeOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let routeOne = NSMutableAttributedString(string: "Route  :  ", attributes: routeAttributes)
            let routeTwo = NSMutableAttributedString(string: "\(route)", attributes: routeOtherAttributes)
            let route_examcombination = NSMutableAttributedString()
            route_examcombination.append(routeOne)
            route_examcombination.append(routeTwo)
          //  cell.routeLbl.attributedText = route_examcombination
            
            let frequencyAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let frequencyOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let frequencyOne = NSMutableAttributedString(string: "Frequency  :  ", attributes: frequencyAttributes)
            let frequencyTwo = NSMutableAttributedString(string: "\(frequency)/day", attributes: frequencyOtherAttributes)
            let frequency_examcombination = NSMutableAttributedString()
            frequency_examcombination.append(frequencyOne)
            frequency_examcombination.append(frequencyTwo)
           // cell.frequencyLbl.attributedText = frequency_examcombination
            
            let durationAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let durationOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let durationOne = NSMutableAttributedString(string: "Duration  :  ", attributes: durationAttributes)
            let durationTwo = NSMutableAttributedString(string: "\(duration) Months", attributes: durationOtherAttributes)
            let duration_examcombination = NSMutableAttributedString()
            duration_examcombination.append(durationOne)
            duration_examcombination.append(durationTwo)
           // cell.durationLbl.attributedText = duration_examcombination
            
            let refillAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let refillOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let refillOne = NSMutableAttributedString(string: "Refills  :  ", attributes: refillAttributes)
            let refillTwo = NSMutableAttributedString(string: "\(refill)", attributes: refillOtherAttributes)
            let refill_examcombination = NSMutableAttributedString()
            refill_examcombination.append(refillOne)
            refill_examcombination.append(refillTwo)
           // cell.refillsLbl.attributedText = refill_examcombination
            
            let convertDate = Double(refillExpireAt)
            let date = Date(timeIntervalSince1970: convertDate ?? 0)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd MMM yyyy"
            //dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            
          //  cell.ExpiresLbl.text = "Expired: \(strDate)"
            
         //   cell.PrescriptionLbl.text = "Prescription #\(prescriptionNumber)"
          //  cell.accessoryType = .checkmark
            
            return cell
            
        }
    }
    
    @objc func HandleTap1(_ sender:UIButton) {
       
    }
    
    
    @objc func HandleTap(_ sender:UIButton) {
        let dict = DataManager.getVal(self.data_Array[sender.tag]) as! NSDictionary
        let sts = DataManager.getVal(dict["appStatus"]) as? String ?? ""
        idnew = DataManager.getVal(dict["_id"]) as? String ?? ""
        if sts == "1" {
              let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
              let alert = SCLAlertView(appearance: appearance)
              alert.addButton("Yes", backgroundColor: Config().AppNavBlueColor){
               self.PendingTap_API()
               NotificationCenter.default.post(name: NSNotification.Name("APICALLNEW"), object: nil)
              }
              alert.addButton("No", backgroundColor: Config().AppNavBlueColor){
                  print("No")
              }
              alert.showEdit("Remove Item", subTitle: "Are you sure you want to remove this item?")
        }else {
            
        }
       
    }
    
    
    func PendingTap_API(){
          
           let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(DataManager.getVal(idnew), forKey: "id")
           parameterDictionary.setValue(DataManager.getVal("false"), forKey: "status")
           print(parameterDictionary)
           
           let methodName = "/updateStatus"
           
           getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
               if error == nil{
                   let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                   let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                   
                   if success == "1"{
                    let defaults = UserDefaults.standard
                    defaults.set("DataNew", forKey: "DataShow")
                    defaults.synchronize()
                   }else{
                       Config().error(message: message)
                   }
                  
               }
           }
       }
       
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
        let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
        let cd = DataManager.getVal(dict["_id"])
        var DetailButtonFlag = Bool()
        let printFlag = DataManager.getVal(dict["printFlag"]) as? String ?? ""
        if tableView == PendingtblView{
            
            let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
            DetailButtonFlag = true
            vc.DetailButtonFlag = DetailButtonFlag
            vc.tabType = "Pending"
            vc.str_id = _id
            self.onlyPushViewController(vc)
            
//            let indexPath = PendingtblView.indexPathForSelectedRow
//
//            if indexPath!.row != lastSelectedIndexPath.row {
//
//                if select_type_array.contains(_id)
//                {
//                    ns.remove(cd)
//                    ns.remove(prcPrice)
//                    select_type_array.removeAll { $0 == _id }
//                    select_type_array.removeAll {$0 == prcPrice}
//                    nsnewArray.remove(cd)
//                    nsnewArray1.remove(prcPrice)
//                    let defaults = UserDefaults.standard
//                    defaults.set(self.ns, forKey: "Array")
//                    defaults.synchronize()
//
//                    let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
//                    DetailButtonFlag = true
//                    vc.DetailButtonFlag = DetailButtonFlag
//                    vc.tabType = "Pending"
//                    vc.str_id = _id
//                    self.onlyPushViewController(vc)
//
//                }
//                else
//                {
//                    select_type_array.append(_id)
//                    select_type_array.append(prcPrice)
//
//                    nsnewArray.add(cd)
//                    ns.add(cd)
//                    ns.add(prcPrice)
//                    let defaults = UserDefaults.standard
//                    defaults.set(self.ns, forKey: "Array")
//                    defaults.set(nsnewArray, forKey: "Arrayid")
//                    defaults.synchronize()
//
//                    let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
//                    DetailButtonFlag = true
//                    vc.DetailButtonFlag = DetailButtonFlag
//                    vc.tabType = "Pending"
//                    vc.str_id = _id
//                    self.onlyPushViewController(vc)
//
//                }
//                self.PendingtblView.reloadData()
//
//
//            }else {
//                let newCell = PendingtblView.cellForRow(at: indexPath!)
//                newCell?.accessoryType = .none
//            }
            
        }else if tableView == ActiveTblView{
            let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
            DetailButtonFlag = true
            vc.DetailButtonFlag = DetailButtonFlag
            vc.tabType = "Active"
            vc.str_id = _id
            self.onlyPushViewController(vc)
        }else if tableView == InProgressTblView{
            let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
            DetailButtonFlag = true
            vc.DetailButtonFlag = DetailButtonFlag
            vc.str_id = _id
            vc.tabType = "InProcess"
            self.onlyPushViewController(vc)
        }else{
            let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
            DetailButtonFlag = true
            vc.DetailButtonFlag = DetailButtonFlag
            vc.str_id = _id
            vc.tabType = "Expired"
            vc.printFlat = printFlag
            self.onlyPushViewController(vc)
          //  self.showAnimate(YourHiddenView: self.ActiveHiddenView, ishidden: false)
        }
    }
    
    @IBAction func checkOutBtnAction(_ sender: Any) {
              print("Button tapped")
               var DetailButtonFlag = Bool()
               select_type_arrayNew = defaults.array(forKey: "Array") as? [String]
              // nsnewArray1.removeObject(at: 0)
               defaults.set(nsnewArray1, forKey: "Arrayprice")
               idar = defaults.array(forKey: "Arrayid") as NSArray?
               prar = defaults.array(forKey: "Arrayprice") as NSArray?
                

                let vc = CheckOutPaymentVC(nibName: "CheckOutPaymentVC", bundle: nil)
                DetailButtonFlag = true
                vc.DetailButtonFlag = DetailButtonFlag
                vc.tabType = "Pending"
                vc.idarray = idar
                vc.pricearray = prar
                self.onlyPushViewController(vc)
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
    
    func showAnimate(YourHiddenView: UIView,ishidden: Bool){
        self.view.window?.addSubview(YourHiddenView)
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
    
}
extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
