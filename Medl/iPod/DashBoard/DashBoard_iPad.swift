//
//  DashBoard_iPad.swift
//  Medl
//
//  Created by mac-15 on 24/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//



import UIKit

class DashBoard_iPad: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @IBOutlet weak var PendingButtonOutlet: MyButton!
    @IBOutlet weak var ActiveButtonOutlet: MyButton!
    @IBOutlet weak var ExpiredButtonOutlet: MyButton!
    @IBOutlet weak var InProcessButtonOutlet: MyButton!
    
    @IBOutlet weak var ActiveCollectionView: UICollectionView!
    @IBOutlet weak var PendingCollectionView: UICollectionView!
    @IBOutlet weak var InProcessCollectionView: UICollectionView!
    @IBOutlet weak var ExpiredCollectionView: UICollectionView!
    
   
    @IBOutlet weak var CheckOutBtn: UIButton!
    
    @IBOutlet var popDetailView: UIView!
    //MARK:-PendingHiddenView
       @IBOutlet var DetailButtonHiddenView: UIView!
    
    
    //MARK:-INPROGRESS_HiddenView
    
    //@IBOutlet var InProgessHiddenView: UIView!
   
    
    var selectedIds = [Int] ()
    var count = 15
    var data_Array = [Any]()
    var refillExpireAt = String()
    
    var detail_Data_Dict = [String: Any]()
    var doctor_data_dict = [String: Any]()
    var select_type_array = [String]()
    var select_type_arrayNew:[String]!
    var lastSelectedIndexPath = NSIndexPath(row: -1, section: 0)
    var ArrayCountCheckMessage = "1"
    var selectedArray = [Any]()
    var nsnewArray = NSMutableArray()
    var nsnewArray1 = NSMutableArray()
    var idar:NSArray!
    var prar:NSArray!
    var nsmuta = NSMutableArray()
    var idnew:String!
    var appsts:String!
    var defaults:UserDefaults!
    var ns = NSMutableArray()
    var parachute = UIButton()
    var my_lbl = UILabel()
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
        self.navigationController?.isNavigationBarHidden = true
       NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvert1(_:)), name: NSNotification.Name("APICALL"), object: nil)
                   
        NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvert5(_:)), name: NSNotification.Name("APICALLNEW"), object: nil)
                
        
        let Pending_LiberaryLayOut = UICollectionViewFlowLayout()
        Pending_LiberaryLayOut.itemSize = CGSize(width: screenWidth/2-30, height: 90)
        Pending_LiberaryLayOut.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        Pending_LiberaryLayOut.minimumInteritemSpacing = 20
        Pending_LiberaryLayOut.minimumLineSpacing = 20
        Pending_LiberaryLayOut.scrollDirection = .vertical
              
        let Pending_LayOutClassNearBy = UINib(nibName: "Pending_iPadCollectionCell", bundle: nil)
        self.PendingCollectionView.register(Pending_LayOutClassNearBy, forCellWithReuseIdentifier: "Pending_iPadCollectionCell")
        self.PendingCollectionView.collectionViewLayout = Pending_LiberaryLayOut
        
        let LiberaryLayOut = UICollectionViewFlowLayout()
        LiberaryLayOut.itemSize = CGSize(width: screenWidth/2-30, height: 106)
        LiberaryLayOut.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        LiberaryLayOut.minimumInteritemSpacing = 20
        LiberaryLayOut.minimumLineSpacing = 20
        LiberaryLayOut.scrollDirection = .vertical
        
        let LayOutClassNearBy = UINib(nibName: "Active_iPadCollectionCell", bundle: nil)
        self.ActiveCollectionView.register(LayOutClassNearBy, forCellWithReuseIdentifier: "Active_iPadCollectionCell")
        self.ActiveCollectionView.collectionViewLayout = LiberaryLayOut
        
      
        
        
        let InProcess_LiberaryLayOut = UICollectionViewFlowLayout()
        InProcess_LiberaryLayOut.itemSize = CGSize(width: screenWidth/2-30, height: 90)
        InProcess_LiberaryLayOut.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        InProcess_LiberaryLayOut.minimumInteritemSpacing = 20
        InProcess_LiberaryLayOut.minimumLineSpacing = 20
        InProcess_LiberaryLayOut.scrollDirection = .vertical
        
        let InProcess_LayOutClassNearBy = UINib(nibName: "InProcess_iPadCollectionCell", bundle: nil)
        self.InProcessCollectionView.register(InProcess_LayOutClassNearBy, forCellWithReuseIdentifier: "InProcess_iPadCollectionCell")
        self.InProcessCollectionView.collectionViewLayout = InProcess_LiberaryLayOut
        
       
        
        let Expired_LiberaryLayOut = UICollectionViewFlowLayout()
        Expired_LiberaryLayOut.itemSize = CGSize(width: screenWidth/2-30, height: 285)
        Expired_LiberaryLayOut.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        Expired_LiberaryLayOut.minimumInteritemSpacing = 20
        Expired_LiberaryLayOut.minimumLineSpacing = 20
        Expired_LiberaryLayOut.scrollDirection = .vertical
        
        let Expired_LayOutClassNearBy = UINib(nibName: "ExpiredCollectionCell", bundle: nil)
        self.ExpiredCollectionView.register(Expired_LayOutClassNearBy, forCellWithReuseIdentifier: "ExpiredCollectionCell")
        self.ExpiredCollectionView.collectionViewLayout = Expired_LiberaryLayOut
        
        
        self.DetailButtonHiddenView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
      
        self.PendingButtonAction(PendingButtonOutlet)
        self.DashBoard_API(status: "Pending")
        
        
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
                my_lbl.layer.cornerRadius = 5.0
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
        
        SocketIoManager.sharedInstance.establishConnection()
        
        
        
        
    }
    
     override func viewWillAppear(_ animated: Bool) {
         UserDefaults.standard.removeObject(forKey: "date")
    }
    
    @IBAction func checkOutBtnAction(_ sender: Any) {
        print("Button tapped")
        var DetailButtonFlag = Bool()
        select_type_arrayNew = defaults.array(forKey: "Array") as? [String]
     // nsnewArray1.removeObject(at: 0)
        defaults.set(nsnewArray1, forKey: "Arrayprice")
        idar = defaults.array(forKey: "Arrayid") as NSArray?
        prar = defaults.array(forKey: "Arrayprice") as NSArray?
       

         let vc = EnterAddress_IpadVC(nibName: "EnterAddress_IpadVC", bundle: nil)
         DetailButtonFlag = true
         vc.DetailButtonFlag = DetailButtonFlag
         vc.tabType = "Pending"
         vc.idarray = idar
         vc.pricearray = prar
         self.onlyPushViewController(vc)
    }
    
    @objc func parachuteAction(sender: UIButton!) {
     
     let alertControl = UIAlertController(title: "Medl Assist", message: "Do you need assistance with your order?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
             let alertControl = UIAlertController(title: "Medl Assist", message: "Would you like a medl representative to call you yo assist you with your order?", preferredStyle: .alert)
             
             let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
                 let typeIdArrayString = self.defaults.value(forKey: "iduser")
                     
                     var dictPaitient = [String:Any]()
                     dictPaitient = ["type": "parachute","user_id": typeIdArrayString!]
                     
                     let typeIdArrayStringnew = self.JSONStringify(value: dictPaitient as AnyObject)
                     
                   //  SocketIoManager.sharedInstance.sendMessage(withSender: typeIdArrayStringnew)
                 SocketIoManager.sharedInstance.connectToServerWiththirdRoom(nickname: typeIdArrayStringnew)
                         NotificationCenter.default.addObserver(self, selector: #selector(self.currencyConvert3(_:)), name: NSNotification.Name("notificationNameStudentnew"), object: nil)
                     
               }
             let action2 = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
             }
             alertControl.addAction(action1)
             alertControl.addAction(action2)
             
             self.present(alertControl, animated: true, completion: nil)
                    
              }
            let action2 = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
            }
            alertControl.addAction(action1)
            alertControl.addAction(action2)
            
            self.present(alertControl, animated: true, completion: nil)
     
       print("Button tapped")
          defaults = UserDefaults.standard
    

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
    
    @objc func currencyConvert1(_ pNotification: Notification?) {
           self.DashBoard_API(status: "Pending")
          }
       
       @objc func currencyConvert5(_ pNotification: Notification?) {
           self.DashBoard_API(status: "Pending")
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
                
                if success == "1"{
                    self.data_Array = DataManager.getVal(responseData?.object(forKey: "data")) as? [Any] ?? []
                    
                    let appdata = DataManager.getVal(responseData?.object(forKey: "appdata")) as? String ?? ""
                    
                    if self.appsts == "pending" {
                        if appdata == "0" {
                        self.CheckOutBtn.isHidden = true
                        }else {
                        self.CheckOutBtn.isHidden = false
                        }
                    if self.data_Array.count == 0 {
                          self.parachute.isHidden = true
                          self.my_lbl.isHidden = true
                      }else {
                          self.parachute.isHidden = false
                          self.my_lbl.isHidden = false
                      }
                        
                    }else if self.appsts == "active" {
                          print("Active")
                          self.parachute.isHidden = true
                    }else if self.appsts == "inprocess" {
                          self.parachute.isHidden = true
                          print("Inprocess")
                    }else {
                        self.parachute.isHidden = true
                        print("Expire")
                    }
                    
                    self.PendingCollectionView.reloadData()
                    self.ActiveCollectionView.reloadData()
                    self.InProcessCollectionView.reloadData()
                    self.ExpiredCollectionView.reloadData()
                    
                }else{
                    Config().error(message: message)
                    self.CheckOutBtn.isHidden = true
                    self.parachute.isHidden = true
                    self.my_lbl.isHidden = true
                }
                self.clearHud()
            }
        }
    }
    
    
    @IBAction func ActiverossButtonAction(_ sender: UIButton) {
       
    }
   
   
    
    @IBAction func InProgressCrossButtonAction(_ sender: UIButton) {
        self.removeAnimate(YourHiddenView: self.DetailButtonHiddenView, ishidden: true)
    }
  
    @IBAction func PendingButtonAction(_ sender: MyButton) {
         appsts = "pending"
        self.ArrayCountCheckMessage = "1"
        self.PendingButtonOutlet.setTitleColor(Config().AppWhiteColor, for: .normal)
        self.PendingButtonOutlet.backgroundColor = Config().AppButtonOrangeColor
        self.PendingButtonOutlet.layer.cornerRadius = 4
        
        self.ActiveButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.ActiveButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.ActiveButtonOutlet.layer.cornerRadius = 4
        self.ActiveButtonOutlet.layer.borderWidth = 1
        self.ActiveButtonOutlet.borderColor = Config().AppNavBlueColor
        
        self.ExpiredButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.ExpiredButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.ExpiredButtonOutlet.layer.cornerRadius = 4
        self.ExpiredButtonOutlet.layer.borderWidth = 1
        self.ExpiredButtonOutlet.borderColor = Config().AppGrayColor
        
        self.InProcessButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.InProcessButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.InProcessButtonOutlet.layer.cornerRadius = 4
        self.InProcessButtonOutlet.layer.borderWidth = 1
        self.InProcessButtonOutlet.borderColor = Config().AppYellowColor
        
        self.ActiveCollectionView.isHidden = true
        self.PendingCollectionView.isHidden = false
        self.InProcessCollectionView.isHidden = true
        self.ExpiredCollectionView.isHidden = true
        
        DispatchQueue.main.async {
            self.DashBoard_API(status: "Pending")
        }
        //self.PendingCollectionView.reloadData()
    }
    @IBAction func ActiveButtonAction(_ sender: MyButton) {
         appsts = "active"
        self.ArrayCountCheckMessage = "2"
        self.PendingButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.PendingButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.PendingButtonOutlet.layer.cornerRadius = 4
        self.PendingButtonOutlet.layer.borderWidth = 1
        self.PendingButtonOutlet.borderColor = Config().AppButtonOrangeColor
        
        self.ActiveButtonOutlet.setTitleColor(Config().AppWhiteColor, for: .normal)
        self.ActiveButtonOutlet.backgroundColor = Config().AppGreenColor
        self.ActiveButtonOutlet.layer.cornerRadius = 4
        self.ActiveButtonOutlet.layer.borderWidth = 1
        self.ActiveButtonOutlet.borderColor = Config().AppNavBlueColor
        
        self.ExpiredButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.ExpiredButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.ExpiredButtonOutlet.layer.cornerRadius = 4
        self.ExpiredButtonOutlet.layer.borderWidth = 1
        self.ExpiredButtonOutlet.borderColor = Config().AppGrayColor
        
        self.InProcessButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.InProcessButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.InProcessButtonOutlet.layer.cornerRadius = 4
        self.InProcessButtonOutlet.layer.borderWidth = 1
        self.InProcessButtonOutlet.borderColor = Config().AppYellowColor
        
        self.ActiveCollectionView.isHidden = false
        self.PendingCollectionView.isHidden = true
        self.InProcessCollectionView.isHidden = true
        self.ExpiredCollectionView.isHidden = true
        DispatchQueue.main.async {
            self.DashBoard_API(status: "Active")
        }
        //self.ActiveCollectionView.reloadData()
        
    }
    @IBAction func InProcessButtonAction(_ sender: MyButton) {
         appsts = "inprocess"
        self.ArrayCountCheckMessage = "3"
        self.PendingButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.PendingButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.PendingButtonOutlet.layer.cornerRadius = 4
        self.PendingButtonOutlet.layer.borderWidth = 1
        self.PendingButtonOutlet.borderColor = Config().AppButtonOrangeColor
        
        self.ActiveButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.ActiveButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.ActiveButtonOutlet.layer.cornerRadius = 4
        self.ActiveButtonOutlet.layer.borderWidth = 1
        self.ActiveButtonOutlet.borderColor = Config().AppNavBlueColor
        
        self.ExpiredButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.ExpiredButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.ExpiredButtonOutlet.layer.cornerRadius = 4
        self.ExpiredButtonOutlet.layer.borderWidth = 1
        self.ExpiredButtonOutlet.borderColor = Config().AppGrayColor
        
        self.InProcessButtonOutlet.setTitleColor(Config().AppWhiteColor, for: .normal)
        self.InProcessButtonOutlet.backgroundColor = Config().AppYellowColor
        self.InProcessButtonOutlet.layer.cornerRadius = 4
        self.InProcessButtonOutlet.layer.borderWidth = 1
        self.InProcessButtonOutlet.borderColor = Config().AppYellowColor
        
        self.ActiveCollectionView.isHidden = true
        self.PendingCollectionView.isHidden = true
        self.InProcessCollectionView.isHidden = false
        self.ExpiredCollectionView.isHidden = true
        DispatchQueue.main.async {
            self.DashBoard_API(status: "InProcess")
        }
        //self.InProcessCollectionView.reloadData()
        
    }
    
    @IBAction func ExpiredButtonAction(_ sender: MyButton) {
         appsts = "expire"
        self.ArrayCountCheckMessage = "4"
        self.PendingButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.PendingButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.PendingButtonOutlet.layer.cornerRadius = 4
        self.PendingButtonOutlet.layer.borderWidth = 1
        self.PendingButtonOutlet.borderColor = Config().AppButtonOrangeColor
        
        self.ActiveButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.ActiveButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.ActiveButtonOutlet.layer.cornerRadius = 4
        self.ActiveButtonOutlet.layer.borderWidth = 1
        self.ActiveButtonOutlet.borderColor = Config().AppNavBlueColor
        
        self.ExpiredButtonOutlet.setTitleColor(Config().AppWhiteColor, for: .normal)
        self.ExpiredButtonOutlet.backgroundColor = Config().AppGrayColor
        self.ExpiredButtonOutlet.layer.cornerRadius = 4
        self.ExpiredButtonOutlet.layer.borderWidth = 1
        self.ExpiredButtonOutlet.borderColor = Config().AppGrayColor
        
        self.InProcessButtonOutlet.setTitleColor(Config().AppGrayColor, for: .normal)
        self.InProcessButtonOutlet.backgroundColor = Config().AppWhiteColor
        self.InProcessButtonOutlet.layer.cornerRadius = 4
        self.InProcessButtonOutlet.layer.borderWidth = 1
        self.InProcessButtonOutlet.borderColor = Config().AppYellowColor
        
        self.ActiveCollectionView.isHidden = true
        self.PendingCollectionView.isHidden = true
        self.InProcessCollectionView.isHidden = true
        self.ExpiredCollectionView.isHidden = false
        DispatchQueue.main.async {
            self.DashBoard_API(status: "Expired")
        }
        //self.ExpiredCollectionView.reloadData()
        
    }
    
    
    //Mark:TableView Delegete
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
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableCell", for: indexPath) as! PaymentTableCell
        
        cell.btn_check.tag = indexPath.row
        cell.btn_check.addTarget(self, action: #selector(brandSelected(sender:)), for: .touchUpInside)
        
        for i in 0 ..< selectedIds.count {
            if selectedIds[i] == indexPath.row {
                cell.btn_check.isSelected = true
                break
            }
            else
            {
                cell.btn_check.isSelected = false
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //Mark:CollectionView Delegete
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.PendingCollectionView{
            if self.data_Array.count == 0{
                self.PendingCollectionView.backgroundView = UIImageView(image: UIImage(named: "NoPending"))
            }else{
                self.PendingCollectionView.backgroundView = nil
            }
            return self.data_Array.count
        }else if collectionView == self.InProcessCollectionView{
            if self.data_Array.count == 0{
                self.InProcessCollectionView.backgroundView = UIImageView(image: UIImage(named: "InProgressBack"))
            }else{
                self.InProcessCollectionView.backgroundView = nil
            }
            return self.data_Array.count
        }else if collectionView == self.ActiveCollectionView{
            if self.data_Array.count == 0{
                self.ActiveCollectionView.backgroundView = UIImageView(image: UIImage(named: "Active"))
            }else{
                self.ActiveCollectionView.backgroundView = nil
            }
            return self.data_Array.count
        }else{
            if self.data_Array.count == 0{
                self.ExpiredCollectionView.backgroundView = UIImageView(image: UIImage(named: "NoExpiredPrescriptions"))
            }else{
                self.ExpiredCollectionView.backgroundView = nil
            }
            return self.data_Array.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.PendingCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pending_iPadCollectionCell", for: indexPath) as! Pending_iPadCollectionCell
            cell.backgroundColor = UIColor.clear
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let doctor_dict = DataManager.getVal(dict["doctorId"]) as! NSDictionary
            //let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            let formulationName = DataManager.getVal(dict["recommendedFormulation"]) as? String ?? ""
            let firstName = DataManager.getVal(doctor_dict["firstName"]) as? String ?? ""
            let lastName = DataManager.getVal(doctor_dict["lastName"]) as? String ?? ""
            
            //cell.titleNameLbl.text = typeName
            cell.titleNameLbl.text = formulationName
            cell.issuedByLbl.text = "Dr.\(firstName + lastName)"
            
              let sts = DataManager.getVal(dict["appStatus"]) as? String ?? ""
               if sts == "1" {
               cell.select_btn.setImage(UIImage(named:"pendingcheck"), for: .normal)
               cell.select_btn.tag = indexPath.row
               cell.select_btn.addTarget(self, action: #selector(HandleTap(_:)), for: .touchUpInside)
               let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
                      let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
                      let cd = DataManager.getVal(dict["_id"])
                     
                      if select_type_array.contains(_id)
                      {
                          ns.remove(cd)
                          select_type_array.removeAll { $0 == _id }
                          nsnewArray.remove(cd)
                         
                          let defaults = UserDefaults.standard
                          defaults.set(self.ns, forKey: "Array")
                          defaults.synchronize()

                      }
                      else
                      {
                          select_type_array.append(_id)
                          nsnewArray.add(cd)
                          ns.add(cd)
                          let defaults = UserDefaults.standard
                          defaults.set(self.ns, forKey: "Array")
                          defaults.set(nsnewArray, forKey: "Arrayid")
                          defaults.synchronize()


                      }
                              
                              
                                      
                       }else{
                           cell.select_btn.tag = indexPath.row
                           cell.select_btn.addTarget(self, action: #selector(HandleTap1(_:)), for: .touchUpInside)
                           cell.select_btn.setImage(UIImage(named:"Group 3"), for: .normal)
                       }
                       
            
            return cell
            
        }else if collectionView == self.ActiveCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Active_iPadCollectionCell", for: indexPath) as! Active_iPadCollectionCell
             let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            
            if let doctorId = DataManager.getVal(dict["doctorId"]) as? NSDictionary{
                let firstName = DataManager.getVal(doctorId["firstName"]) as? String ?? ""
                let lastName = DataManager.getVal(doctorId["lastName"]) as? String ?? ""
                
                let doctorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOne = NSMutableAttributedString(string: "Dr. ", attributes: doctorAttributes)
                let doctorTwo = NSMutableAttributedString(string: "\(firstName.capitalizingFirstLetter() + lastName)", attributes: doctorOtherAttributes)
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
            cell.titleLbl.text = typeName.capitalizingFirstLetter()
            
            return cell
            
        }else if collectionView == self.InProcessCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InProcess_iPadCollectionCell", for: indexPath) as! InProcess_iPadCollectionCell
            let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
            let typeName = DataManager.getVal(dict["typeName"]) as? String ?? ""
            
            if let doctorId = DataManager.getVal(dict["doctorId"]) as? NSDictionary{
                let firstName = DataManager.getVal(doctorId["firstName"]) as? String ?? ""
                let lastName = DataManager.getVal(doctorId["lastName"]) as? String ?? ""
                
                let doctorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let doctorOne = NSMutableAttributedString(string: "Dr. ", attributes: doctorAttributes)
                let doctorTwo = NSMutableAttributedString(string: "\(firstName.capitalizingFirstLetter() + lastName)", attributes: doctorOtherAttributes)
                let doctor_examcombination = NSMutableAttributedString()
                doctor_examcombination.append(doctorOne)
                doctor_examcombination.append(doctorTwo)
                cell.issuedByLbl.attributedText = doctor_examcombination
            }
            
            cell.titleNameLbl.text = typeName.capitalizingFirstLetter()
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpiredCollectionCell", for: indexPath) as! ExpiredCollectionCell
            
            
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
          
          cell.titleLbl.text = typeName.capitalizingFirstLetter()
          cell.descLbl.text = recommendedFormulation
          
          let notes = DataManager.getVal(dict["notes"]) as? String ?? ""
          
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
              let doctorTwo = NSMutableAttributedString(string: "\(firstName.capitalizingFirstLetter() + lastName)", attributes: doctorOtherAttributes)
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
          
          let convertDate = Double(refillExpireAt)
          let date = Date(timeIntervalSince1970: convertDate ?? 0)
          let dateFormatter = DateFormatter()
          dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
          dateFormatter.locale = NSLocale.current
          dateFormatter.dateFormat = "dd-MMM-yyyy"
          //dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
          let strDate = dateFormatter.string(from: date)
          
          cell.ExpiresLbl.text = "Expired: \(strDate)"
          
          cell.PrescriptionLbl.text = "Prescription #\(prescriptionNumber)"
         // cell.accessoryType = .checkmark
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
                          
                      }else{
                          Config().error(message: message)
                      }
                     
                  }
              }
          }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = DataManager.getVal(self.data_Array[indexPath.row]) as! NSDictionary
                let _id = DataManager.getVal(dict["_id"]) as? String ?? ""
                let cd = DataManager.getVal(dict["_id"])
                var DetailButtonFlag = Bool()
        
                if collectionView == PendingCollectionView{
                   // let indexPath1 = PendingCollectionView.indexPathsForSelectedItems
                    if indexPath.row != lastSelectedIndexPath.row {

                        if select_type_array.contains(_id)
                        {
                            ns.remove(cd)
                            select_type_array.removeAll { $0 == _id }
                            nsnewArray.remove(cd)
                            let defaults = UserDefaults.standard
                            defaults.set(self.ns, forKey: "Array")
                            defaults.synchronize()

                            let vc = DasboardDetail_IpadVC(nibName: "DasboardDetail_IpadVC", bundle: nil)
                            DetailButtonFlag = true
                            vc.DetailButtonFlag = DetailButtonFlag
                            vc.tabType = "Pending"
                            vc.str_id = _id
                            self.onlyPushViewController(vc)

                        }
                        else
                        {
                            select_type_array.append(_id)

                            nsnewArray.add(cd)
                            ns.add(cd)

                            let defaults = UserDefaults.standard
                            defaults.set(self.ns, forKey: "Array")
                            defaults.set(nsnewArray, forKey: "Arrayid")
                            defaults.synchronize()

                            let vc = DasboardDetail_IpadVC(nibName: "DasboardDetail_IpadVC", bundle: nil)
                            DetailButtonFlag = true
                            vc.DetailButtonFlag = DetailButtonFlag
                            vc.tabType = "Pending"
                            vc.str_id = _id
                            self.onlyPushViewController(vc)

                        }
                        self.PendingCollectionView.reloadData()
                        
                        
                    }else {
                        let newCell = PendingCollectionView.cellForItem(at: indexPath)
                        
                    }
                    
                }else if collectionView == ActiveCollectionView{
                    let vc = DasboardDetail_IpadVC(nibName: "DasboardDetail_IpadVC", bundle: nil)
                    DetailButtonFlag = true
                    vc.DetailButtonFlag = DetailButtonFlag
                    vc.tabType = "Active"
                    vc.str_id = _id
                    self.onlyPushViewController(vc)
                }else if collectionView == InProcessCollectionView{
                    let vc = DasboardDetail_IpadVC(nibName: "DasboardDetail_IpadVC", bundle: nil)
                    DetailButtonFlag = true
                    vc.DetailButtonFlag = DetailButtonFlag
                    vc.str_id = _id
                    vc.tabType = "InProcess"
                    self.onlyPushViewController(vc)
                }else{
                    self.showAnimate(YourHiddenView: self.popDetailView, ishidden: false)
                }
    }
    //MARK:- Navigation Bar Button Action
    
    @IBAction func LogOutButtonAction(_ sender: UIButton) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("YES", backgroundColor: Config().AppNavBlueColor){
            Config().AppUserDefaults.set("no", forKey: "login")
            
            let vc = LoginVC_iPod(nibName: "LoginVC_iPod", bundle: nil)
            self.RootViewControllerWithNav(vc)
        }
        alert.addButton("NO", backgroundColor: Config().AppNavBlueColor){
            print("NO")
        }
        alert.showEdit("LOGOUT", subTitle: "Are you sure you want to logout?")
        
    }
    @IBAction func NotificationButtonAction(_ sender: UIButton) {
        let vc = NotificationVC_iPad(nibName: "NotificationVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
    }
    
    @IBAction func SupportButtonAction(_ sender: UIButton) {
        let vc = SupportVC_iPad(nibName: "SupportVC_iPad", bundle: nil)
        self.onlyPushViewController(vc)
        
    }
    @IBAction func EditAccountButtonAction(_ sender: UIButton) {
        let vc = EditAccount_iPad(nibName: "EditAccount_iPad", bundle: nil)
        self.onlyPushViewController(vc)
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
    
    
    @IBAction func yesBtnAction(_ sender: Any) {
        self.removeAnimate(YourHiddenView: self.popDetailView, ishidden: true)
        let vc = EnterAddress_IpadVC(nibName: "EnterAddress_IpadVC", bundle: nil)
        self.onlyPushViewController(vc)
    }
    
    @IBAction func CancelBtnAction(_ sender: Any) {
        self.removeAnimate(YourHiddenView: self.popDetailView, ishidden: true)
    }
    
    
    func viewPrescriptionsDetail_API(id: String){
        self.showHud()
        let parameterDictionary = NSMutableDictionary()
        print(parameterDictionary)
        
        let methodName = "/viewPrescriptionsDetail?_id=\(id)"
        
        getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
            if error == nil{
                let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                
                if success == "1"{
                    
                    self.detail_Data_Dict = DataManager.getVal(responseData?.object(forKey: "data")) as! [String: Any]
                    self.doctor_data_dict = DataManager.getVal(self.detail_Data_Dict["doctorId"]) as! [String: Any]
                    let firstName = DataManager.getVal(self.doctor_data_dict["firstName"]) as? String ?? ""
                    let lastName = DataManager.getVal(self.doctor_data_dict["lastName"]) as? String ?? ""
                    
                    let typeName = DataManager.getVal(self.detail_Data_Dict["typeName"]) as? String ?? ""
                    let formulationName = DataManager.getVal(self.detail_Data_Dict["recommendedFormulation"]) as? String ?? ""
                    let format = DataManager.getVal(self.detail_Data_Dict["format"]) as? String ?? ""
                    let frequency = DataManager.getVal(self.detail_Data_Dict["frequency"]) as? String ?? ""
                    let route = DataManager.getVal(self.detail_Data_Dict["route"]) as? String ?? ""
                    let refill = DataManager.getVal(self.detail_Data_Dict["refill"]) as? String ?? ""
                    let pricePerPec = DataManager.getVal(self.detail_Data_Dict["pricePerPec"]) as? String ?? ""
                    let notes = DataManager.getVal(self.detail_Data_Dict["notes"]) as? String ?? ""
                  
                    
                    let routeAttributes = [NSAttributedString.Key.foregroundColor: Config().AppBlackColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                    let routeOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                    let routeOne = NSMutableAttributedString(string: "Route: ", attributes: routeAttributes)
                    let routeTwo = NSMutableAttributedString(string: "\(route)", attributes: routeOtherAttributes)
                    let route_examcombination = NSMutableAttributedString()
                    route_examcombination.append(routeOne)
                    route_examcombination.append(routeTwo)
                  
                    
                    let refillAttributes = [NSAttributedString.Key.foregroundColor: Config().AppBlackColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                    let refillOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                    let refillOne = NSMutableAttributedString(string: "Refills: ", attributes: refillAttributes)
                    let refillTwo = NSMutableAttributedString(string: "\(refill)", attributes: refillOtherAttributes)
                    let refill_examcombination = NSMutableAttributedString()
                    refill_examcombination.append(refillOne)
                    refill_examcombination.append(refillTwo)
                    
                    
                    
                }else{
                    Config().error(message: message)
                }
            }
            self.clearHud()
        }
    }
    
    func ActiveviewPrescriptionsDetail_API(id: String){
        
        self.showHud()
        
        let parameterDictionary = NSMutableDictionary()
        print(parameterDictionary)
        
        let methodName = "/viewPrescriptionsDetail?_id=\(id)"
        
        getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
            if error == nil{
                let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                
                if success == "1"{
                    
                    self.detail_Data_Dict = DataManager.getVal(responseData?.object(forKey: "data")) as! [String: Any]
                    self.doctor_data_dict = DataManager.getVal(self.detail_Data_Dict["doctorId"]) as! [String: Any]
                    let firstName = DataManager.getVal(self.doctor_data_dict["firstName"]) as? String ?? ""
                    let lastName = DataManager.getVal(self.doctor_data_dict["lastName"]) as? String ?? ""
                    
                    let typeName = DataManager.getVal(self.detail_Data_Dict["typeName"]) as? String ?? ""
                    let format = DataManager.getVal(self.detail_Data_Dict["format"]) as? String ?? ""
                    let frequency = DataManager.getVal(self.detail_Data_Dict["frequency"]) as? String ?? ""
                    let route = DataManager.getVal(self.detail_Data_Dict["route"]) as? String ?? ""
                    let refill = DataManager.getVal(self.detail_Data_Dict["refill"]) as? String ?? ""
                    let pricePerPec = DataManager.getVal(self.detail_Data_Dict["pricePerPec"]) as? String ?? ""
                    let notes = DataManager.getVal(self.detail_Data_Dict["notes"]) as? String ?? ""
                  
                    
                    let routeAttributes = [NSAttributedString.Key.foregroundColor: Config().AppBlackColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                    let routeOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                    let routeOne = NSMutableAttributedString(string: "Route: ", attributes: routeAttributes)
                    let routeTwo = NSMutableAttributedString(string: "\(route)", attributes: routeOtherAttributes)
                    let route_examcombination = NSMutableAttributedString()
                    route_examcombination.append(routeOne)
                    route_examcombination.append(routeTwo)
                    
                    
                    let refillAttributes = [NSAttributedString.Key.foregroundColor: Config().AppBlackColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                    let refillOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                    let refillOne = NSMutableAttributedString(string: "Refills: ", attributes: refillAttributes)
                    let refillTwo = NSMutableAttributedString(string: "\(refill)", attributes: refillOtherAttributes)
                    let refill_examcombination = NSMutableAttributedString()
                    refill_examcombination.append(refillOne)
                    refill_examcombination.append(refillTwo)
                    
                    
                }else{
                    Config().error(message: message)
                }
            }
            self.clearHud()
        }
    }
    
    func confirmPurchase_Api(id: String){
        
        self.showHud()
        let parameterDictionary = NSMutableDictionary()
        print(parameterDictionary)
        
        let methodName = "/viewPrescriptionsDetail?_id=\(id)"
        
        getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
            if error == nil{
                let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                
                if success == "1"{
                    
                    self.detail_Data_Dict = DataManager.getVal(responseData?.object(forKey: "data")) as! [String: Any]
                    self.doctor_data_dict = DataManager.getVal(self.detail_Data_Dict["doctor_data_dict"]) as! [String: Any]
                    let firstName = DataManager.getVal(self.doctor_data_dict["firstName"]) as? String ?? ""
                    let lastName = DataManager.getVal(self.doctor_data_dict["lastName"]) as? String ?? ""
                    
                    let typeName = DataManager.getVal(self.detail_Data_Dict["typeName"]) as? String ?? ""
                    let format = DataManager.getVal(self.detail_Data_Dict["format"]) as? String ?? ""
                    let frequency = DataManager.getVal(self.detail_Data_Dict["frequency"]) as? String ?? ""
                    let route = DataManager.getVal(self.detail_Data_Dict["route"]) as? String ?? ""
                    let refill = DataManager.getVal(self.detail_Data_Dict["refill"]) as? String ?? ""
                    let pricePerPec = DataManager.getVal(self.detail_Data_Dict["pricePerPec"]) as? String ?? ""
                    
                    let routeAttributes = [NSAttributedString.Key.foregroundColor: Config().AppBlackColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                    let routeOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                    let routeOne = NSMutableAttributedString(string: "Route: ", attributes: routeAttributes)
                    let routeTwo = NSMutableAttributedString(string: "\(route)", attributes: routeOtherAttributes)
                    let route_examcombination = NSMutableAttributedString()
                    route_examcombination.append(routeOne)
                    route_examcombination.append(routeTwo)
                   
                    
                    let refillAttributes = [NSAttributedString.Key.foregroundColor: Config().AppBlackColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                    let refillOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                    let refillOne = NSMutableAttributedString(string: "Refills: ", attributes: refillAttributes)
                    let refillTwo = NSMutableAttributedString(string: "\(refill)", attributes: refillOtherAttributes)
                    let refill_examcombination = NSMutableAttributedString()
                    refill_examcombination.append(refillOne)
                    refill_examcombination.append(refillTwo)
                   
                    
                }else{
                    Config().error(message: message)
                }
            }
            self.clearHud()
        }
    }
    
    @objc func brandSelected (sender : UIButton) {
        print (sender.tag)
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            
            selectedIds.append(sender.tag)
        }else{
            for i in 0 ..< selectedIds.count {
                if sender.tag == selectedIds[i] {
                    selectedIds.remove(at: i)
                }
            }
        }
    }
}

