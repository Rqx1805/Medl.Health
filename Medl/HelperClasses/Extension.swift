
import UIKit
import AVFoundation
import AVKit
import SVProgressHUD
import Alamofire
var currentTrack: Int = 0
var badgeCountTimer = Timer()

var isPlaying:Bool = false

var audioPlayer:AVAudioPlayer?
var timer:Timer!
var trackCount: Int = 0
var audioArray = [Any]()
var audioURL = String()


extension UIButton {
    
    func dropButtonShadow() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = Config().AppGrayColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.0
    }
}

extension UITextField {
    func setTextFieldBottomLine(Frame: CGRect,Placeholder:String,tag:Int,returnType: UIReturnKeyType,Delegate: UITextFieldDelegate,placeHolderColor: UIColor, TextSize: CGFloat) {
        
        self.frame = Frame
        self.attributedPlaceholder = NSAttributedString(string: Placeholder,attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor]);
        self.delegate = Delegate
        self.returnKeyType = returnType
        self.tag = tag
        self.borderStyle = UITextField.BorderStyle.none
        self.font = Config().AppGlobalFont(TextSize, isBold: false)
        self.textColor = Config().AppWhiteColor
        self.clearButtonMode = UITextField.ViewMode.whileEditing
        self.layer.borderColor = Config().AppWhiteColor.cgColor
        self.layer.borderWidth = 0.5
        
        let leftVw = UIView(frame:CGRect(x: 0,y: 0,width: 10,height: 40))
        self.leftViewMode = UITextField.ViewMode.always
        self.leftView = leftVw
    }
    
    func dropTextFieldShadow() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = Config().AppGrayColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.0
    }
}
extension UITextView {
    
    func dropTextViewShadow() {
        self.layer.cornerRadius = 5
        //self.layer.masksToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = Config().AppGrayColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.0
    }
}
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
extension UIView {
    
    func dropShadow() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = Config().AppGrayColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.0
    }
}
extension UIViewController{
    func getallApiResultwithGetMethod(Methodname : String,parameter: NSDictionary, completionHandler : @escaping (NSDictionary?, NSError?) -> ()){
        
        var strToken = ""
        if UserDefaults.standard.object(forKey: "token") != nil{
            strToken = UserDefaults.standard.object(forKey: "token")! as? String ?? ""
        }
        print("Token :",strToken)
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json",
            "Authorization":  "Bearer " + strToken  // signature
        ]
        
        let url = Config().API_URL + Methodname
        
        print("CheckUrl: ",url)
        print("CheckParameters: ",parameter)
        
        Alamofire.request(url, method: .get, parameters: parameter as? Parameters, encoding: URLEncoding.default, headers: headers).responseJSON{ response in
            let status = response.response?.statusCode
            print("response = ",status as Any)
            print("response = ",response)
            
            DispatchQueue.main.async {
                completionHandler(response.result.value as! NSDictionary? , response.result.error as NSError?)
            }
            
            #if DEBUG
            //print("signUpResponse Debug Data: \(String(describing: response.result.value))")
            #endif
        }
    }
    
    func getallApiResultwithGetMethodNew(Methodname : String,parameter: NSDictionary, completionHandler : @escaping (NSDictionary?, NSError?) -> ()){
        
        var strToken = ""
        if UserDefaults.standard.object(forKey: "token") != nil{
            strToken = UserDefaults.standard.object(forKey: "token")! as? String ?? ""
        }
        print("Token :",strToken)
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json",
            "Authorization":  "Bearer " + strToken  // signature
        ]
        
        let url = Config().API_URLNew + Methodname
        
        print("CheckUrl: ",url)
        print("CheckParameters: ",parameter)
        
        Alamofire.request(url, method: .get, parameters: parameter as? Parameters, encoding: URLEncoding.default, headers: headers).responseJSON{ response in
            let status = response.response?.statusCode
            print("response = ",status as Any)
            print("response = ",response)
            
            DispatchQueue.main.async {
                completionHandler(response.result.value as! NSDictionary? , response.result.error as NSError?)
            }
            
            #if DEBUG
            //print("signUpResponse Debug Data: \(String(describing: response.result.value))")
            #endif
        }
    }
     
     
    func getallApiResultwithPostTokenMethod(parameter: NSDictionary,Methodname : String, completionHandler : @escaping (NSDictionary?, NSError?) -> ()){
        var strToken = ""
        if UserDefaults.standard.object(forKey: "token") != nil{
            strToken = UserDefaults.standard.object(forKey: "token")! as? String ?? ""
        }
        print("Token ==========>> Authorization",  "Bearer " + strToken)
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
           // "Accept": "application/json",
            "Authorization":  "Bearer " + strToken
            
        ]
        print(" Header =====>>> \(headers)")
        let url = Config().API_URL + Methodname
        print("ApiURL ==========>>",url)
        print("ApiParameters: ==========>>",parameter)
        
        Alamofire.request(url, method: .post, parameters: parameter as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            DispatchQueue.main.async {
                completionHandler(response.result.value as! NSDictionary? , response.result.error as NSError?)
                print("API_Response ========>> ", response)
                print("Error ========>> ",response.result.error)
                
            }
            
            #if DEBUG
            //print("signUpResponse Debug Data: \(String(describing: response.result.value))")
            #endif
        }
    }
    func getAllApiResults(parameter: NSDictionary,MethodName : String, completionHandler : @escaping (NSDictionary?, NSError?) -> ()){
        let url = Config().API_URL + MethodName
        print("ApiURL ==========>> ",url)
        print("ApiParameters: ==========>>",parameter)
        
        
        Alamofire.request(url, method: .post, parameters: parameter as? Parameters, encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            print("API_Response ========>> ", response)
            DispatchQueue.main.async {
                completionHandler(response.result.value as! NSDictionary? , response.result.error as NSError?)
                
            }
            
            #if DEBUG
            //print("signUpResponse Debug Data: \(String(describing: response.result.value))")
            #endif
        }
    }
    
    // Ajeet
    
    func getAllApiResultsWithStatus(parameter: NSDictionary,MethodName : String, completionHandler : @escaping (NSDictionary?, NSError?,Int?) -> ()){
           let url = Config().API_URL + MethodName
           print("ApiURL ==========>> ",url)
           print("ApiParameters: ==========>>",parameter)
           
           
           Alamofire.request(url, method: .post, parameters: parameter as? Parameters, encoding: URLEncoding.default, headers: nil).responseJSON{ response in
               print("API_Response ========>> ", response)
               DispatchQueue.main.async {
                completionHandler(response.result.value as! NSDictionary? , response.result.error as NSError?,response.response?.statusCode)
                   
               }
               
               #if DEBUG
               //print("signUpResponse Debug Data: \(String(describing: response.result.value))")
               #endif
           }
       }
    
    func getallApiResultwithPostTokenMethodWithStatus(parameter: NSDictionary,Methodname : String, completionHandler : @escaping (NSDictionary?, NSError?,Int?) -> ()){
           var strToken = ""
           if UserDefaults.standard.object(forKey: "token") != nil{
               strToken = UserDefaults.standard.object(forKey: "token")! as? String ?? ""
           }
           print("Token ==========>> Authorization",  "Bearer " + strToken)
           
           let headers: HTTPHeaders = [
               "Content-Type":"application/json",
              // "Accept": "application/json",
               "Authorization":  "Bearer " + strToken
               
           ]
           print(" Header =====>>> \(headers)")
           let url = Config().API_URL + Methodname
           print("ApiURL ==========>>",url)
           print("ApiParameters: ==========>>",parameter)
           
           Alamofire.request(url, method: .post, parameters: parameter as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
               DispatchQueue.main.async {
                completionHandler(response.result.value as! NSDictionary? , response.result.error as NSError?,response.response?.statusCode)
                   print("API_Response ========>> ", response)
                   print("Error ========>> ",response.result.error)
                   
               }
               
               #if DEBUG
               //print("signUpResponse Debug Data: \(String(describing: response.result.value))")
               #endif
           }
       }
    //Ajeet
    
    

    func showHud()  {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    func clearHud()  {
        SVProgressHUD.dismiss()
    }
    func RootViewWithSideManu(_ RootViewController: UIViewController){
        
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let initialViewController = SearchVC(nibName: "SearchVC", bundle: nil)
        //        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
        //
        //        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:RootViewController), leftMenuViewController: leftController)
        //        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        //        slideMenuController.delegate = initialViewController
        //        self.view.window?.rootViewController = slideMenuController
        
    }
    
    func presentViewController(_ PresentController: UIViewController){
        let DetailVC = PresentController
        let navctrl = UINavigationController(rootViewController: DetailVC)
        self.present(navctrl, animated: true, completion: nil)
    }
    func RootViewControllerWithOutNav(_ RootViewController: UIViewController){
        let slideInFromLeftTransition = CATransition()
        slideInFromLeftTransition.duration = 0.3
        slideInFromLeftTransition.type = .fade
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromBottom;
        self.view.window?.layer.add(slideInFromLeftTransition, forKey: kCATransition)
        self.view.window?.rootViewController = RootViewController
    }
    func RootViewControllerWithNav(_ RootViewController: UIViewController){
        let slideInFromLeftTransition = CATransition()
        slideInFromLeftTransition.duration = 0.2
        slideInFromLeftTransition.type = .fade
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromBottom;
        self.view.window?.layer.add(slideInFromLeftTransition, forKey: kCATransition)
        let navctrl = UINavigationController(rootViewController: RootViewController)
        self.view.window?.rootViewController = navctrl
    }
    func onlyPushViewController(_ PushController: UIViewController){
        let DetailVC = PushController
        self.navigationController?.pushViewController(DetailVC, animated: true)
        
    }
}
extension UIImageView {
    
    func setBackShadowImageView(){
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        
        
    }
}

extension UIView {
    
    func setBackShadow(){
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        
        
    }
    
    // OUTPUT 1
    func dropShadow1(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow2(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension CALayer{
    
    func setLayer(Frame: CGRect){
        self.frame = Frame
        self.backgroundColor = Config().AppLineColor.cgColor
    }
    
}
func convertStringToAny(StringOfAny: String) -> Any? {
    
    let dataOfString = StringOfAny.data(using: String.Encoding.utf8, allowLossyConversion: false)
    
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: dataOfString!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableArray
        return jsonObject
    }
    catch let error as NSError {
        print(error)
        return nil
    }
    
}
extension String {
    var html2AttributedWhite: NSAttributedString? {
        do {
            
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: 10pt !important;" +
                "text-align: 10pt !important;" +
                "color: #f5f5f5 !important;" +
                "font-family: Helvetica Neue;" +
            "}</style>"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
            
        } catch {
            print("error: ", error)
            return nil
        }
        
    }
    
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
    
    
    
    var utfData: Data? {
        return self.data(using: .utf8)
    }
    
    var attributedHtmlString: NSAttributedString? {
        guard let data = self.utfData else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,
                                          options: [
                                            .documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func setHtmlText(_ html: String)-> NSAttributedString {
        
        return html.attributedHtmlString!
        
    }
    
    
}
extension UIColor {
    
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
