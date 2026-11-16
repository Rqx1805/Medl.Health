//
//  BackBaseSupport.swift
//  Medl
//
//  Created by MAC-27 on 08/06/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class BackBaseSupport: UIViewController ,UITextFieldDelegate {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var titleImg = UIImageView()

    var EditImage = "Setting_White"
    var SupportImage = "Send-active"
    var Notification_Image = "NotificationMobile"
    var backImage = "back-2"
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //self.navigationController?.navigationBar.barTintColor = Config().AppNavYellowColor//BackGroundColor
        let backImg : UIImage? = UIImage(named:backImage)!.withRenderingMode(.alwaysOriginal)
        //        self.navigationController?.navigationBar.barTintColor = Config().AppNavYellowColor//BackGroundColor
                self.navigationController?.navigationBar.tintColor = Config().AppWhiteColor//BackButtonTextColor
                self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                let BarButtonItemAppearance = UIBarButtonItem.appearance()
                BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
                self.navigationController?.navigationBar.isTranslucent = false
                let navigation = UIBarButtonItem(image: backImg,  style: .plain, target: self, action: #selector(self.backToHOmePage(_:)))
                self.navigationItem.leftBarButtonItem = navigation
                navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
                //self.navigationItem.backBarButtonItem?.title = "Back"
                self.navigationItem.leftItemsSupplementBackButton = true
                self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Config().AppWhiteColor
        
//        self.titleImg.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
//        self.titleImg.image = UIImage(named: "LeftIcon")
//        self.titleImg.contentMode = .scaleAspectFit
//        self.titleImg.clipsToBounds = true
//        self.navigationItem.titleView = self.titleImg
        
        let editImage : UIImage? = UIImage(named:EditImage)!.withRenderingMode(.alwaysOriginal)
        let ShareImage : UIImage? = UIImage(named:SupportImage)!.withRenderingMode(.alwaysOriginal)
        let NotificationImage : UIImage? = UIImage(named:Notification_Image)!.withRenderingMode(.alwaysOriginal)
        let LogOutImage : UIImage? = UIImage(named:"logOut_White")!.withRenderingMode(.alwaysOriginal)


        let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: #selector(self.Setting_button_Action))
        let ShareButton = UIBarButtonItem(image: ShareImage,  style: .plain, target: self, action: #selector(self.share_button_Action))
        let NotificationButton   = UIBarButtonItem(image: NotificationImage,  style: .plain, target: self, action: #selector(self.Notification_button_Action))
        let LogOutButton = UIBarButtonItem(image: LogOutImage,  style: .plain, target: self, action: #selector(self.LogOut_button_Action))
        
//        let container = UIView(frame: CGRect(x: -7, y: -5,width: 20,height: 17))
//        let button = UIButton(frame: CGRect(x: -7, y: -5,width: 20,height: 17))
//        button.addTarget(self, action: #selector(backToHOmePage), for: .touchUpInside)
//        button.setImage(UIImage(named: "LeftIcon"), for: .normal)
//        button.sizeToFit()
//        container.addSubview(button)
//        container.sizeToFit()
//        navigationItem.titleView = container
        

        self.navigationItem.rightBarButtonItems = [LogOutButton, NotificationButton, ShareButton, editButton]

    }
    
    @objc func done(_ selector: ResponsiveButton){
    }
    
    @objc func backToHOmePage(_ selector: UIBarButtonItem){
        let vc = DashBoard(nibName: "DashBoard", bundle: nil)
        self.RootViewControllerWithNav(vc)
    }
    
    
    @objc func Notification_button_Action(_ selector: UIBarButtonItem){
        let vc = NotificationVC(nibName: "NotificationVC", bundle: nil)
        self.onlyPushViewController(vc)
        
    }
    @objc func Setting_button_Action(_ selector: UIBarButtonItem){
        let vc = AddProfileVC(nibName: "AddProfileVC", bundle: nil)
        self.onlyPushViewController(vc)
    }
    @objc func share_button_Action(_ selector: UIBarButtonItem){
//        let vc = SupportVC(nibName: "SupportVC", bundle: nil)
//        self.onlyPushViewController(vc)
    }
    @objc func LogOut_button_Action(_ selector: UIBarButtonItem){
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("Yes", backgroundColor: Config().AppNavBlueColor){
            self.Logout_API()
        }
        alert.addButton("No", backgroundColor: Config().AppNavBlueColor){
            print("No")
        }
        alert.showEdit("Logout", subTitle: "Are you sure you want to logout?")
        
    }
    
    func Logout_API(){
          let parameterDictionary = NSMutableDictionary()
          let userid = UserDefaults.standard.value(forKey: "iduser") as? String
          parameterDictionary.setValue(DataManager.getVal(userid), forKey: "id")
          print(parameterDictionary)
          
          let methodName = "/logout"
          
           getallApiResultwithPostTokenMethod(parameter: parameterDictionary, Methodname: methodName) { (responseData, error) in
              if error == nil{
                  let success = DataManager.getVal(responseData?["success"]) as? String ?? ""
                  let message = DataManager.getVal(responseData?["message"]) as? String ?? ""
                  DispatchQueue.main.async {
                      if success == "1"{
                         Config().AppUserDefaults.set("no", forKey: "login")
                          let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                          self.RootViewControllerWithNav(vc)
                      }else{
                          Config().error(message: message)
                      }
                      
                  }
              }
          }
      }

}
