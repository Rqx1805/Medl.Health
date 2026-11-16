

import Foundation
import UIKit
import CRNotifications
class Config: NSObject,UIAlertViewDelegate {
    
//    let API_URL = "https://devnode.devtechnosys.tech:17301/api/medl/patient"
//    let API_URL1 = "https://devnode.devtechnosys.tech:17301/api/medl/patient/"
//    let API_URLNew = "https://devnode.devtechnosys.tech:17301/api/medl/cart-item"
    
    let API_URL = "https://medl.me:17301/api/medl/patient"
    let API_URL1 = "https://medl.me:17301/api/medl/patient/"
    let API_URLNew = "https://medl.me:17301/api/medl/cart-item"
    
   
    //https://devnode.devtechnosys.tech:17301/api/medl/pharmacist/searchMedicine?name=Humira
    let AppAlertTitle = "MEDL"
    let API_TermsCondition = "/Terms-Condition"
    let AppUserDefaults = UserDefaults.standard
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let API_updateDetail = "updateDetail"
    
    let debug_mode = 1
    let NO_IMAGE = "NoImage"
    
    let USER_NO_IMAGE = "NoImage"
    var shownIndexes : [IndexPath] = []
    let CELL_HEIGHT : CGFloat = 40
    
   
    
    /********************************* App Color Codes ***************************************/
    let AppBackgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    let AppNavBlueColor = UIColor(red: 25/255, green: 51/255, blue: 86/255, alpha: 1.0)
    let AppGreenColor = UIColor(red: 83/255, green: 172/255, blue: 144/255, alpha: 1.0)
    let AppGrayColor = UIColor(red: 181/255, green: 181/255, blue: 181/255, alpha: 1.0)
    
    let AppYellowColor = UIColor(red: 249/255, green: 188/255, blue: 5/255, alpha: 1.0)
    
    let AppBrownColor = UIColor(red: 231/255, green: 149/255, blue: 41/255, alpha: 1.0)
    let AppButtonOrangeColor = UIColor(red: 246/255, green: 109/255, blue: 4/255, alpha: 1.0)
    let AppLineColor = UIColor.lightText
    let AppBlackColor = UIColor.black
    let AppRedColor = UIColor(red: 233/255, green: 62/255, blue: 39/255, alpha: 1.0)
    let AppAppleColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
    
    let AppWhiteColor = UIColor.white
    let AppClearColor = UIColor.clear
    
    func printData(_ dataValue : Any ){
        if debug_mode == 1 {
            print(dataValue)
        }
    }
    func success(message: String){
        CRNotifications.showNotification(type: CRNotifications.success, title: "Success!", message: message, dismissDelay: 3)
    }
    func error(message: String){
        CRNotifications.showNotification(type: CRNotifications.error, title: "Error", message: message, dismissDelay: 3)
    }
    func info(message: String){
        CRNotifications.showNotification(type: CRNotifications.info, title: "info", message: message, dismissDelay: 3)
    }
    
    func AppGlobalFont(_ fontSize:CGFloat,isBold:Bool) -> UIFont {
        
        let fontName : String!
        fontName = (isBold) ? "Lato-Bold" : "Lato-Regular"
        
        return UIFont(name: fontName, size: fontSize)!
    }
    
    
}




