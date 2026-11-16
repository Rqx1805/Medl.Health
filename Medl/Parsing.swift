//
//  Parsing.swift
//  Medl
//
//  Created by Ashish Soni on 18/08/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class Parsing: NSObject {
    
    ///Get Reason Detail----
    func GetTermsConsition(){
        
        let API_Path = "\(Config().API_URL)"
        let API_Method = "\(Config().API_TermsCondition)"
        
        let Parameter = String(format: "%@%@", API_Path,API_Method)
        
        var request = URLRequest(url: URL(string: Parameter)!)
        request.httpMethod = "GET"
        
        let postString = String(format: "")
        
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            // else {
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
            var jsonResult  = NSDictionary()
            jsonResult  = (try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            print("jsonResult: \(jsonResult)")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GetTermsConsition"), object: self, userInfo: jsonResult as? [AnyHashable : Any])
            //  }
        }
        task.resume()
    }
//    let parameterDictionary = NSMutableDictionary()
//                             parameterDictionary.setValue(DataManager.getVal(self.EmailAddressTxtField.text!), forKey: "email")
//                             parameterDictionary.setValue(DataManager.getVal(self.PasswordTxtField.text!), forKey: "password")
//                             parameterDictionary.setValue(DataManager.getVal(self.mobileNumber), forKey: "mobile")
//                             parameterDictionary.setValue(DataManager.getVal(self.str_deviceid), forKey: "deviceId")
//
    //MARK:- Student Forgot Password API -----  ForgotPasswordController
    func SignUpMedl(Email: String!,Password:String!,Mobile:String!,DeviceId:String!){
           let API_Path = "\(Config().API_URL1)"
           let API_Method = "\(Config().API_updateDetail)"
           
           let Parameter = String(format: "%@%@", API_Path,API_Method)
           
           var request = URLRequest(url: URL(string: Parameter)!)
           request.httpMethod = "POST"
           
           let postString = String(format: "email=%@&password=%@&mobile=%@&deviceId=%@", Email,Password,Mobile,DeviceId)
           
           request.httpBody = postString.data(using: .utf8)
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               guard let data = data, error == nil else {
                   
                   // check for fundamental networking error
                   print("error=\(String(describing: error))")
                   return
               }
               if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                   print("statusCode should be 200, but is \(httpStatus.statusCode)")
                   print("response = \(String(describing: response))")
               }
               
               let responseString = String(data: data, encoding: .utf8)
               print("responseString = \(String(describing: responseString))")
               
               var jsonResult  = NSDictionary()
               jsonResult  = (try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
               print("jsonResult: \(jsonResult)")
               
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SignUpMedlNotification"), object: self, userInfo: jsonResult as? [AnyHashable : Any])
           }
           task.resume()
       }

}
