//
//  DashBoardNotification.swift
//  Medl
//
//  Created by MAC-27 on 05/06/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class DashBoardNotification: BaseViewController, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var MenuCollectionView: UICollectionView!
    
    @IBOutlet weak var PendingtblView: UITableView!
    @IBOutlet weak var ActiveTblView: UITableView!
    @IBOutlet weak var InProgressTblView: UITableView!
    @IBOutlet weak var ExpireTblView: UITableView!
    
    //MARK:-ActiveHiddenView
    @IBOutlet var ActiveHiddenView: UIView!
    
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
    var lastSelectedIndexPath = NSIndexPath(row: -1, section: 0)
    var checkout = UIButton()
    var parachute = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults = UserDefaults.standard
        if select_type_array.count == 0 {
            
        }else {
            select_type_array = defaults.array(forKey: "Array") as! [String]
        }
        
        DispatchQueue.main.async {
            self.showHud()
            self.DashBoard_API(status: "Pending")
            self.PendingtblView.reloadData()
        }
//        DispatchQueue.main.async {
//            self.showHud()
//            self.DashBoard_API(status: "Expired")
//            self.ExpireTblView.reloadData()
//        }
        
        
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
        LiberaryLayOut1.itemSize = CGSize(width: 124, height: 50)
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
        
        
        checkout.backgroundColor = .lightGray
        checkout.setTitle("CHECKOUT", for: .normal)
        checkout.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(checkout)
        checkout.translatesAutoresizingMaskIntoConstraints = false
        checkout.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkout.widthAnchor.constraint(equalToConstant: 162).isActive = true
        checkout.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        checkout.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkout.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        
        parachute.backgroundColor = .lightGray
        parachute.setTitle("PARACHUTE", for: .normal)
        parachute.addTarget(self, action: #selector(parachuteAction), for: .touchUpInside)

        self.view.addSubview(parachute)
        parachute.translatesAutoresizingMaskIntoConstraints = false
        parachute.heightAnchor.constraint(equalToConstant: 50).isActive = true
        parachute.widthAnchor.constraint(equalToConstant: 162).isActive = true
        parachute.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        parachute.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        parachute.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        
        self.PendingtblView.isHidden = false
        self.ActiveTblView.isHidden = true
        self.InProgressTblView.isHidden = true
        self.ExpireTblView.isHidden = true
        self.checkout.isHidden = true
        self.parachute.isHidden = true
        
        SocketIoManager.sharedInstance.establishConnection()
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
        
            let indexPath = sender.tag
                let dict = DataManager.getVal(self.data_Array[indexPath]) as! NSDictionary
                let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
                let  typeIdArrayString = self.JSONStringify(value: ns as AnyObject)
                print(typeIdArrayString)
                let sentenceFromElements = select_type_array.joined(separator: ",")
                defaults.set(sentenceFromElements, forKey: "Array")
                defaults.synchronize()
        
//                SocketIoManager.sharedInstance.connectToServerWithRoom(nickname: sentenceFromElements)
//                SocketIoManager.sharedInstance.sendMessage(withSender: sentenceFromElements)
////                for i in 0..<select_type_array.count {
////                     let dict = DataManager.getVal(self.data_Array[i]) as! NSDictionary
////                     let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
////                     SocketIoManager.sharedInstance.sendMessage(withSender: _id)
////               }
                let vc = EnterYourAddressVC(nibName: "EnterYourAddressVC", bundle: nil)
                vc._idArray = [sentenceFromElements]
                self.onlyPushViewController(vc)

    }
    
    @objc func parachuteAction(sender: UIButton!) {
          print("Button tapped")
            
            let indexPath = sender.tag
                    let dict = DataManager.getVal(self.data_Array[indexPath]) as! NSDictionary
                    let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
    //                SocketIoManager.sharedInstance.establishConnection()
                    let  typeIdArrayString = self.JSONStringify(value: ns as AnyObject)
                    print(typeIdArrayString)
                    let sentenceFromElements = select_type_array.joined(separator: ",")
                    SocketIoManager.sharedInstance.connectToServerWithSecondRoom(nickname: sentenceFromElements)
                    SocketIoManager.sharedInstance.sendMessage(withSender: sentenceFromElements)
    //                for i in 0..<select_type_array.count {
    //                     let dict = DataManager.getVal(self.data_Array[i]) as! NSDictionary
    //                     let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
    //                     SocketIoManager.sharedInstance.sendMessage(withSender: _id)
    //               }
        let alert = UIAlertController(title: "Alert", message: "Our Customer executive call you shortly", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.checkout.isHidden = true
        self.parachute.isHidden = true
        self.PendingtblView.reloadData()
        self.present(alert, animated: true, completion: nil)

        }
    
    func viewWillAppear(animated: Bool) {
        
        if let index = self.PendingtblView.indexPathForSelectedRow {
            
            self.PendingtblView.deselectRow(at: index, animated: true)
    
        }
    }
    
    @objc func refreshPending(sender: UIRefreshControl) {
       // Code to refresh table view
        self.PendingtblView.reloadData()
        self.pendingRefreshControl.endRefreshing()
        self.DashBoard_API(status: "Pending")
    }
    @objc func refreshInProcess(sender: UIRefreshControl) {
       // Code to refresh table view
        self.InProgressTblView.reloadData()
        self.inProcessRefreshControl.endRefreshing()
        self.DashBoard_API(status: "InProcess")
    }
    @objc func refreshActive(sender: UIRefreshControl) {
       // Code to refresh table view
        self.ActiveTblView.reloadData()
        self.activeRefreshControl.endRefreshing()
        self.DashBoard_API(status: "Active")
    }
    @objc func refreshExpire(sender: UIRefreshControl) {
       // Code to refresh table view
        self.ExpireTblView.reloadData()
        self.expireRefreshControl.endRefreshing()
        self.DashBoard_API(status: "Expired")
    }
    
    func DashBoard_API(status: String){
        
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
                        
                        self.PendingtblView.reloadData()
                        self.ActiveTblView.reloadData()
                        self.InProgressTblView.reloadData()
                        self.ExpireTblView.reloadData()
                    }else{
                        Config().error(message: message)
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
            cell.layer.borderWidth = 1
            cell.titleLbl.font = cell.titleLbl.font.withSize(16)
            cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.titleLbl.textColor = UIColor.gray
            cell.layer.cornerRadius = 4
            cell.clipsToBounds = true
        }else if indexPath.row == 1{
            // cell.backgroundColor = Config().AppYellowColor
            cell.layer.borderColor = Config().AppGreenColor.cgColor
            cell.layer.borderWidth = 1
            cell.titleLbl.font = cell.titleLbl.font.withSize(16)
            cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.titleLbl.textColor = UIColor.gray
            cell.layer.cornerRadius = 4
            cell.clipsToBounds = true
        }else if indexPath.row == 2{
            //cell.backgroundColor = Config().AppGreenColor
            cell.layer.borderColor = Config().AppYellowColor.cgColor
            cell.layer.borderWidth = 1
            cell.titleLbl.font = cell.titleLbl.font.withSize(16)
            cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.titleLbl.textColor = UIColor.gray
            cell.layer.cornerRadius = 4
            cell.clipsToBounds = true
        }else {
            //cell.backgroundColor = Config().AppGrayColor
            cell.layer.borderColor = Config().AppGrayColor.cgColor
            cell.layer.borderWidth = 1
            cell.titleLbl.font = cell.titleLbl.font.withSize(16)
            cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.titleLbl.textColor = UIColor.gray
            cell.layer.cornerRadius = 4
            cell.clipsToBounds = true
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
        self.selectedCell = indexPath.row
        if indexPath.row == 0{
            self.StatusMesasge = "1"
            self.PendingtblView.isHidden = false
            
            self.ActiveTblView.isHidden = true
            self.InProgressTblView.isHidden = true
            self.ExpireTblView.isHidden = true
            //cell.backgroundColor = Config().AppButtonOrangeColor
            //cell.titleLbl.textColor = Config().AppWhiteColor
            
            DispatchQueue.main.async {
                self.DashBoard_API(status: "Pending")
            }
        }else if indexPath.row == 1{
            self.StatusMesasge = "3"
            self.PendingtblView.isHidden = true
            self.ActiveTblView.isHidden = false
            self.InProgressTblView.isHidden = true
            
            self.ExpireTblView.isHidden = true
            // cell.backgroundColor = Config().AppYellowColor
            // cell.titleLbl.textColor = Config().AppWhiteColor
            DispatchQueue.main.async {
               self.DashBoard_API(status: "Active")
            }
        }else if indexPath.row == 2{
            self.StatusMesasge = "2"
            self.PendingtblView.isHidden = true
            self.ActiveTblView.isHidden = true
            
            self.InProgressTblView.isHidden = false
            self.ExpireTblView.isHidden = true
            // cell.backgroundColor = Config().AppGreenColor
            // cell.titleLbl.textColor = Config().AppWhiteColor
            DispatchQueue.main.async {
               self.DashBoard_API(status: "InProcess")
            }
        }else{
            self.StatusMesasge = "4"
            self.PendingtblView.isHidden = true
            self.ActiveTblView.isHidden = true
            self.InProgressTblView.isHidden = true
            self.ExpireTblView.isHidden = false
            
            // cell.backgroundColor = Config().AppGrayColor
            // cell.titleLbl.textColor = Config().AppWhiteColor
            DispatchQueue.main.async {
               self.DashBoard_API(status: "Expired")
            }
        }
        self.MenuCollectionView.reloadData()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (Config().shownIndexes.contains(indexPath) == false) {
            Config().shownIndexes.append(indexPath)
            
            cell.transform = CGAffineTransform(translationX: 0, y: Config().CELL_HEIGHT)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.alpha = 0
            
            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(0.5)
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            UIView.commitAnimations()
        }
    }
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "PendingTableCell", for: indexPath) as! PendingTableCell
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let doctor_dict = DataManager.getVal(dict["doctorId"]) as! NSDictionary
            let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            let firstName = DataManager.getVal(doctor_dict["firstName"]) as? String ?? ""
            let lastName = DataManager.getVal(doctor_dict["lastName"]) as? String ?? ""
            cell.accessoryType = .none
            cell.titleNameLbl.text = typeName
            cell.issuedByLbl.text = "Dr. \(firstName + lastName)"
            self.checkout.tag = indexPath.row
            self.parachute.tag = indexPath.row
            let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
            if select_type_array.count == 0 {
                 cell.select_btn.setImage(UIImage(named:"Rx_Red"), for: .normal)
                self.checkout.isHidden = true
                self.parachute.isHidden = true
            }else {
                if self.select_type_array.contains(_id){
                    cell.select_btn.setImage(UIImage(named:"pendingcheck"), for: .normal)
                }else{
                    cell.select_btn.setImage(UIImage(named:"Rx_Red"), for: .normal)
                }
                self.checkout.isHidden = false
                self.parachute.isHidden = false
            }
            
            
            
            return cell
        }else if tableView == self.ActiveTblView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveTableCell", for: indexPath) as! ActiveTableCell
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            let recommendedFormulation = DataManager.getVal(dict["recommendedFormulation"]) as? String ?? ""
            let notes = DataManager.getVal(dict["pharmaNotes"]) as? String ?? ""
            
            let notesAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let notesOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let notesOne = NSMutableAttributedString(string: "Notes  :  ", attributes: notesAttributes)
            let notesTwo = NSMutableAttributedString(string: "\(notes)", attributes: notesOtherAttributes)
            let notes_examcombination = NSMutableAttributedString()
            notes_examcombination.append(notesOne)
            notes_examcombination.append(notesTwo)
            cell.NotesLbl.attributedText = notes_examcombination
            
            if let doctorId = DataManager.getVal(dict["doctorId"]) as? NSDictionary{
                let firstName = DataManager.getVal(doctorId["firstName"]) as? String ?? ""
                let lastName = DataManager.getVal(doctorId["lastName"]) as? String ?? ""
                
                let doctorAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let doctorOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOne = NSMutableAttributedString(string: "Issued By  :  ", attributes: doctorAttributes)
                let doctorTwo = NSMutableAttributedString(string: "\(firstName + lastName)", attributes: doctorOtherAttributes)
                let doctor_examcombination = NSMutableAttributedString()
                doctor_examcombination.append(doctorOne)
                doctor_examcombination.append(doctorTwo)
                cell.DoctorNameLbl.attributedText = doctor_examcombination
            }
            
            let unit = DataManager.getVal(dict["quantity"]) as? String ?? ""
            let route = DataManager.getVal(dict["route"]) as? String ?? ""
            let frequency = DataManager.getVal(dict["frequency"]) as? String ?? ""
            let duration = DataManager.getVal(dict["duration"]) as? String ?? ""
            let refill = DataManager.getVal(dict["refill"]) as? String ?? ""
            
            cell.titleLbl.text = typeName
            cell.descLbl.text = recommendedFormulation
            
            let unitAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let unitOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let unitOne = NSMutableAttributedString(string: "Quantity  :  ", attributes: unitAttributes)
            let unitTwo = NSMutableAttributedString(string: "\(unit)", attributes: unitOtherAttributes)
            let unit_examcombination = NSMutableAttributedString()
            unit_examcombination.append(unitOne)
            unit_examcombination.append(unitTwo)
            cell.quantityLbl.attributedText = unit_examcombination
            
            let routeAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let routeOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let routeOne = NSMutableAttributedString(string: "Route  :  ", attributes: routeAttributes)
            let routeTwo = NSMutableAttributedString(string: "\(route)", attributes: routeOtherAttributes)
            let route_examcombination = NSMutableAttributedString()
            route_examcombination.append(routeOne)
            route_examcombination.append(routeTwo)
            cell.routeLbl.attributedText = route_examcombination
            
            let frequencyAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let frequencyOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let frequencyOne = NSMutableAttributedString(string: "Frequency  :  ", attributes: frequencyAttributes)
            let frequencyTwo = NSMutableAttributedString(string: "\(frequency)/day", attributes: frequencyOtherAttributes)
            let frequency_examcombination = NSMutableAttributedString()
            frequency_examcombination.append(frequencyOne)
            frequency_examcombination.append(frequencyTwo)
            cell.frequencyLbl.attributedText = frequency_examcombination
            
            let durationAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let durationOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let durationOne = NSMutableAttributedString(string: "Duration  :  ", attributes: durationAttributes)
            let durationTwo = NSMutableAttributedString(string: "\(duration) Months", attributes: durationOtherAttributes)
            let duration_examcombination = NSMutableAttributedString()
            duration_examcombination.append(durationOne)
            duration_examcombination.append(durationTwo)
            cell.durationLbl.attributedText = duration_examcombination
            
            let refillAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let refillOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let refillOne = NSMutableAttributedString(string: "Refills  :  ", attributes: refillAttributes)
            let refillTwo = NSMutableAttributedString(string: "\(refill)", attributes: refillOtherAttributes)
            let refill_examcombination = NSMutableAttributedString()
            refill_examcombination.append(refillOne)
            refill_examcombination.append(refillTwo)
            cell.refillsLbl.attributedText = refill_examcombination
            
            return cell
            
        }else if tableView == InProgressTblView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InProgressTableCell", for: indexPath) as! InProgressTableCell
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            let recommendedFormulation = DataManager.getVal(dict["recommendedFormulation"]) as? String ?? ""
            let notes = DataManager.getVal(dict["pharmaNotes"]) as? String ?? ""
            
            let notesAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let notesOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let notesOne = NSMutableAttributedString(string: "Notes  :  ", attributes: notesAttributes)
            let notesTwo = NSMutableAttributedString(string: "\(notes)", attributes: notesOtherAttributes)
            let notes_examcombination = NSMutableAttributedString()
            notes_examcombination.append(notesOne)
            notes_examcombination.append(notesTwo)
            cell.notesLbl.attributedText = notes_examcombination
            
            if let doctorId = DataManager.getVal(dict["doctorId"]) as? NSDictionary{
                let firstName = DataManager.getVal(doctorId["firstName"]) as? String ?? ""
                let lastName = DataManager.getVal(doctorId["lastName"]) as? String ?? ""
                
                let doctorAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let doctorOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOne = NSMutableAttributedString(string: "Issued By  :  ", attributes: doctorAttributes)
                let doctorTwo = NSMutableAttributedString(string: "\(firstName + lastName)", attributes: doctorOtherAttributes)
                let doctor_examcombination = NSMutableAttributedString()
                doctor_examcombination.append(doctorOne)
                doctor_examcombination.append(doctorTwo)
                cell.issuedByLbl.attributedText = doctor_examcombination
            }
            
            let unit = DataManager.getVal(dict["quantity"]) as? String ?? ""
            let route = DataManager.getVal(dict["route"]) as? String ?? ""
            let frequency = DataManager.getVal(dict["frequency"]) as? String ?? ""
            let duration = DataManager.getVal(dict["duration"]) as? String ?? ""
            let refill = DataManager.getVal(dict["refill"]) as? String ?? ""
            
            cell.titleNameLbl.text = typeName
            cell.descLbl.text = recommendedFormulation
            
            let unitAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let unitOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let unitOne = NSMutableAttributedString(string: "Quantity  :  ", attributes: unitAttributes)
            let unitTwo = NSMutableAttributedString(string: "\(unit)", attributes: unitOtherAttributes)
            let unit_examcombination = NSMutableAttributedString()
            unit_examcombination.append(unitOne)
            unit_examcombination.append(unitTwo)
            cell.quantityLbl.attributedText = unit_examcombination
            
            let routeAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let routeOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let routeOne = NSMutableAttributedString(string: "Route  :  ", attributes: routeAttributes)
            let routeTwo = NSMutableAttributedString(string: "\(route)", attributes: routeOtherAttributes)
            let route_examcombination = NSMutableAttributedString()
            route_examcombination.append(routeOne)
            route_examcombination.append(routeTwo)
            cell.routeLbl.attributedText = route_examcombination
            
            let frequencyAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let frequencyOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let frequencyOne = NSMutableAttributedString(string: "Frequency  :  ", attributes: frequencyAttributes)
            let frequencyTwo = NSMutableAttributedString(string: "\(frequency)/day", attributes: frequencyOtherAttributes)
            let frequency_examcombination = NSMutableAttributedString()
            frequency_examcombination.append(frequencyOne)
            frequency_examcombination.append(frequencyTwo)
            cell.frequencylbl.attributedText = frequency_examcombination
            
            let durationAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let durationOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let durationOne = NSMutableAttributedString(string: "Duration  :  ", attributes: durationAttributes)
            let durationTwo = NSMutableAttributedString(string: "\(duration) Months", attributes: durationOtherAttributes)
            let duration_examcombination = NSMutableAttributedString()
            duration_examcombination.append(durationOne)
            duration_examcombination.append(durationTwo)
            cell.durationlbl.attributedText = duration_examcombination
            
            let refillAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let refillOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let refillOne = NSMutableAttributedString(string: "Refills  :  ", attributes: refillAttributes)
            let refillTwo = NSMutableAttributedString(string: "\(refill)", attributes: refillOtherAttributes)
            let refill_examcombination = NSMutableAttributedString()
            refill_examcombination.append(refillOne)
            refill_examcombination.append(refillTwo)
            cell.refillLbl.attributedText = refill_examcombination
            
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpireTableCell", for: indexPath) as! ExpireTableCell
            
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            let recommendedFormulation = DataManager.getVal(dict["recommendedFormulation"]) as? String ?? ""
            
            let unit = DataManager.getVal(dict["unit"]) as? String ?? ""
            let route = DataManager.getVal(dict["route"]) as? String ?? ""
            let frequency = DataManager.getVal(dict["frequency"]) as? String ?? ""
            let duration = DataManager.getVal(dict["duration"]) as? String ?? ""
            let refill = DataManager.getVal(dict["refill"]) as? String ?? ""
            self.refillExpireAt = DataManager.getVal(dict["refillExpireAt"]) as? String ?? ""
            //let prescriptionId = DataManager.getVal(dict["prescriptionId"]) as? String ?? ""
            let prescriptionNumber = DataManager.getVal(dict["prescriptionNumber"]) as? String ?? ""
            
            cell.titleLbl.text = typeName
         //   cell.descLbl.text = recommendedFormulation
            
            let notes = DataManager.getVal(dict["notes"]) as? String ?? ""
            
            let notesAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let notesOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let notesOne = NSMutableAttributedString(string: "Notes  :  ", attributes: notesAttributes)
            let notesTwo = NSMutableAttributedString(string: "\(notes)", attributes: notesOtherAttributes)
            let notes_examcombination = NSMutableAttributedString()
            notes_examcombination.append(notesOne)
            notes_examcombination.append(notesTwo)
          //  cell.NotesLbl.attributedText = notes_examcombination
            
            if let doctorId = DataManager.getVal(dict["doctorId"]) as? NSDictionary{
                let firstName = DataManager.getVal(doctorId["firstName"]) as? String ?? ""
                let lastName = DataManager.getVal(doctorId["lastName"]) as? String ?? ""
                
                let doctorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOne = NSMutableAttributedString(string: "Dr.  ", attributes: doctorAttributes)
                let doctorTwo = NSMutableAttributedString(string: "\(firstName + lastName)", attributes: doctorOtherAttributes)
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
        //    cell.quantityLbl.attributedText = unit_examcombination
            
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
          //  cell.frequencyLbl.attributedText = frequency_examcombination
            
            let durationAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let durationOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let durationOne = NSMutableAttributedString(string: "Duration  :  ", attributes: durationAttributes)
            let durationTwo = NSMutableAttributedString(string: "\(duration) Months", attributes: durationOtherAttributes)
            let duration_examcombination = NSMutableAttributedString()
            duration_examcombination.append(durationOne)
            duration_examcombination.append(durationTwo)
          //  cell.durationLbl.attributedText = duration_examcombination
            
            let refillAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavBlueColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let refillOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let refillOne = NSMutableAttributedString(string: "Refills  :  ", attributes: refillAttributes)
            let refillTwo = NSMutableAttributedString(string: "\(refill)", attributes: refillOtherAttributes)
            let refill_examcombination = NSMutableAttributedString()
            refill_examcombination.append(refillOne)
            refill_examcombination.append(refillTwo)
          //  cell.refillsLbl.attributedText = refill_examcombination
            
            let convertDate = Double(refillExpireAt)
            let date = Date(timeIntervalSince1970: convertDate ?? 0)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            //dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            
            //cell.ExpiresLbl.text = "Expired: \(strDate)"
            
          //  cell.PrescriptionLbl.text = "Prescription #\(prescriptionNumber)"
            cell.accessoryType = .checkmark
            
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
        let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
        let cd = DataManager.getVal(dict["_id"])
        var DetailButtonFlag = Bool()
       
        
        if tableView == PendingtblView{
            
            let indexPath = PendingtblView.indexPathForSelectedRow
            if indexPath!.row != lastSelectedIndexPath.row {
                
                if select_type_array.contains(_id)
                {
                    ns.remove(cd)
                    select_type_array.removeAll { $0 == _id }
                    let defaults = UserDefaults.standard
                    defaults.set(self.select_type_array, forKey: "Array")
                    defaults.synchronize()
                    let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
                    DetailButtonFlag = true
                    vc.DetailButtonFlag = DetailButtonFlag
                    vc.tabType = "Pending"
                    vc.str_id = _id
                    self.onlyPushViewController(vc)
                   // isClick = false
                   // checkBtn.setImage(UIImage(named: "ic_check_box_outline_blank_24px"), for: .normal)
                   // NotificationCenter.default.post(name: NSNotification.Name("CheckALl"), object: nil)
                    
                }
                else
                {
                    select_type_array.append(_id)
                    ns.add(cd)
                    let defaults = UserDefaults.standard
                    defaults.set(self.select_type_array, forKey: "Array")
                    defaults.synchronize()
                    let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
                    DetailButtonFlag = true
                    vc.DetailButtonFlag = DetailButtonFlag
                    vc.tabType = "Pending"
                    vc.str_id = _id
                    self.onlyPushViewController(vc)
                    
//                    isClick = true
//                    if select_type_array.count == UserAccountListArray.count {
//                        self.checkBtn.setImage(UIImage(named: "Checkbox"), for: .normal)
//                    }else {
//                        print("Ashish")
//                    }
                }
                self.PendingtblView.reloadData()
                
                
//                let newCell = PendingtblView.cellForRow(at: indexPath!)
//                newCell?.accessoryType = .checkmark
//
//                let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
//                DetailButtonFlag = true
//                vc.DetailButtonFlag = DetailButtonFlag
//                vc.tabType = "Pending"
//                vc.str_id = _id
//                self.onlyPushViewController(vc)
                
            }else {
                let newCell = PendingtblView.cellForRow(at: indexPath!)
                newCell?.accessoryType = .none
            }
            
            
        }else if tableView == ActiveTblView{
            let vc = TabletDetailVC(nibName: "TabletDetailVC", bundle: nil)
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
            self.showAnimate(YourHiddenView: self.ActiveHiddenView, ishidden: false)
        }
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
