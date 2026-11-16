//
//  CheckOutPaymentVC.swift
//  Medl
//
//  Created by Ashish Soni on 28/08/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class CheckOutPaymentVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var cardTableview: UITableView!
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var checkOutBtn: UIButton!
    var idarray:NSArray!
    var idarray1:NSArray!
    var pricearray:NSArray!
    var DetailButtonFlag = Bool()
    var tabType = String()
    var cardArray =  [Any]()
    var idnew:String!
    var priceAr = NSMutableArray()
    var taxAr = NSMutableArray()
    var finalPrArr = NSMutableArray()
    var pricenew = Int()
    var costnew = Int()
    var taxnew = Int()
    var newadd:String!
    var calculationdict:NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CartAPI()
        self.newadd = "add"
        let nibClass = UINib(nibName: "PaymentCheckoutCell", bundle: nil)
        self.cardTableview.register(nibClass, forCellReuseIdentifier: "PaymentCheckoutCell")
        // Do any additional setup after loading the view.
    }
    
     @objc func CartAPI(){
            
            self.showHud()
            let parameterDictionary = NSMutableDictionary()
            print(parameterDictionary)
            
            let methodName = "/cart-item"
            
            getallApiResultwithGetMethod(Methodname: methodName, parameter: parameterDictionary) { (responseData, error) in
                if error == nil{
                    let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                    let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                    DispatchQueue.main.async {
                        if success == "1"{
                            
                        self.cardArray = DataManager.getVal(responseData?.object(forKey: "data")) as? [Any] ?? []
                            var datane = NSMutableArray()
                            datane = NSMutableArray(array: self.cardArray)
                            self.idarray1 = datane.value(forKey: "_id") as? NSArray
                        self.calculationdict = DataManager.getVal(responseData?.object(forKey: "calculation")) as? NSDictionary
                            if self.cardArray.count == 0{
                                NotificationCenter.default.post(name: NSNotification.Name("APICALLNEWONE"), object: nil)
                                self.navigationController?.popViewController(animated: true)
                                let defaults = UserDefaults.standard
                                defaults.set("DataNew", forKey: "DataShow")
                                defaults.synchronize()
                            }else {
                                
                            }
                           // var nsmu = NSMutableArray()
                           // nsmu = NSMutableArray(array: self.cardArray)
                           // self.priceAr = nsmu.value(forKey: "totalPrice") as? NSArray
                            //self.taxAr = nsmu.value(forKey: "substituteTax") as? NSArray
                            self.cardTableview.reloadData()
                        }else{
                            Config().error(message: message)
                        }
                        
                        
                    }
                    self.clearHud()
                }
            }
        }

    @IBAction func checkoutBtnAction(_ sender: Any) {
        let vc = EnterYourAddressVC(nibName: "EnterYourAddressVC", bundle: nil)
        vc.DetailButtonFlag = DetailButtonFlag
        vc.tabType = "Pending"
        vc.idarray = idarray1
        vc.pricearray = pricearray
        vc.prnewAr = priceAr
        vc.finalprar = finalPrArr
        vc.TaxAr = taxAr
        self.onlyPushViewController(vc)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCheckoutCell", for: indexPath) as! PaymentCheckoutCell
        var dict = NSDictionary()
        dict = cardArray[indexPath.row] as! NSDictionary
        
        
        var price:Int!
        var quanrty:Int!
        var taxamnt:Int!
        var taxnew1:Int!
        price = dict.value(forKey: "totalPrice") as? Int
        quanrty = dict.value(forKey: "prescribedAmount") as? Int
        taxamnt = dict.value(forKey: "unitPrice") as? Int
        taxnew1 = dict.value(forKey: "substituteTax") as? Int
        
        var prne:Float!
        prne = Float(price)
        let prnewx = String(format: "%.02f",prne!)
        
        cell.quantyLbl.text =  String(quanrty)
        cell.priceLbl.text = "$" + String(prnewx)
//        var taxamount:Int!
//        taxamount = price*taxamnt/100
        var taxn:Float!
        taxn = Float(taxamnt)
        let taxnew = String(format: "%.02f",taxn!)
      //  cell.taxLbl.text = "TAX:" + "$" + String(taxnew)
//        var costprice:Int!
//        costprice = price + taxamount
//        var costn:Float!
//        costn = Float(costprice)
//        let constnew = String(format: "%.02f",costn!)
        cell.costLbl.text =   "$" + String(taxnew)
        var subtotal:String!
        subtotal = self.calculationdict.value(forKey: "subTotal") as? String
        var taxtl:String!
        taxtl = self.calculationdict.value(forKey: "taxAmount") as? String
        var totalAmount:String!
        totalAmount = self.calculationdict.value(forKey: "totalAmont") as? String
        
        var subproductName:String!
        subproductName = dict.value(forKey: "subsituteProduct") as? String
        
        if subproductName == "" {
            cell.medNameLbl.text = dict.value(forKey: "prescName") as? String
        }else {
            cell.medNameLbl.text = subproductName
        }
        var subfloat:Float!
        subfloat = Float(subtotal)
        var Tlfloat:Float!
        Tlfloat = Float(totalAmount)
        var Taxfloat:Float!
        Taxfloat = Float(taxtl)
        let sub = String(format: "%.02f",subfloat!)
        let tl = String(format: "%.02f",Tlfloat!)
        let tx = String(format: "%.02f",Taxfloat!)
        self.subTotalLbl.text = "$" + String(sub)
        self.totalLbl.text = "$" + String(tl)
        self.taxLbl.text = "$" + String(tx)
        
       // self.taxLbl.text = "$" + String(taxamount)
        self.priceAr.add(sub)
        self.finalPrArr.add(tl)
        self.taxAr.add(tx)
        cell.cancelBtn.tag = indexPath.row
        cell.cancelBtn.addTarget(self, action: #selector(Handletap(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func Handletap(_ sender:UIButton) {
         let dict = DataManager.getVal(self.cardArray[sender.tag]) as! NSDictionary
         idnew = DataManager.getVal(dict["_id"]) as? String ?? ""
        // if sts == "1" {
               let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
               let alert = SCLAlertView(appearance: appearance)
               alert.addButton("Yes", backgroundColor: Config().AppNavBlueColor){
                self.PendingTap_API()
              
               }
               alert.addButton("No", backgroundColor: Config().AppNavBlueColor){
                   print("No")
               }
               alert.showEdit("Remove Item", subTitle: "Are you sure you want to remove this item?")
        // }else {
             
        // }
        
    }
    
    func PendingTap_API(){
       
        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(DataManager.getVal(idnew), forKey: "id")
        parameterDictionary.setValue(DataManager.getVal("false"), forKey: "status")
        print(parameterDictionary)
        
        let methodName = "/cancel-cart-item"
        
        getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
            if error == nil{
                let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                
                if success == "1"{
//                     self.cardArray = DataManager.getVal(responseData?.object(forKey: "data")) as? [Any] ?? []
//                       self.calculationdict = DataManager.getVal(responseData?.object(forKey: "calculation")) as? NSDictionary
//                           if self.cardArray.count == 0{
//                               NotificationCenter.default.post(name: NSNotification.Name("APICALLNEWONE"), object: nil)
//                               self.navigationController?.popViewController(animated: true)
//                               let defaults = UserDefaults.standard
//                               defaults.set("DataNew", forKey: "DataShow")
//                               defaults.synchronize()
                          // }else {
                                self.CartAPI()
                          // }
                          // var nsmu = NSMutableArray()
                           //nsmu = NSMutableArray(array: self.cardArray)
                         //  self.priceAr = nsmu.value(forKey: "totalPrice") as? NSArray
                           //self.taxAr = nsmu.value(forKey: "substituteTax") as? NSArray
                           self.cardTableview.reloadData()
                }else{
                    Config().error(message: message)
                }
               
            }
        }
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
