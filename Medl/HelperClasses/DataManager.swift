import Foundation

import SystemConfiguration


extension NSDictionary{
    
    private func httpStringRepresentation(value: Any) -> String {
        switch value {
        case let boolean as Bool:
            return boolean ? "true" : "false"
        default:
            return "\(value)"
        }
    }
    
    func dataFromHttpParameters() -> NSData? {
        
        var parameterArray = [String]()
        for (key, value) in self {
            let string = httpStringRepresentation(value: value)
            
            if let escapedString = string.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) {
                parameterArray.append("\(key)=\(escapedString)")
            }
        }
        
        let parameterString = parameterArray.joined(separator: "&")
        //print(parameterString)
        
        return parameterString.data(using: String.Encoding.utf8) as NSData?
    }
}



class DataManager {
    
    class func isConnectedToNetwork()->Bool{
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
        
    }
    
    class func getVal(_ param:Any!) -> AnyObject {
        
        if param == nil{
            return "" as AnyObject
        }else if param is NSNull{
            return "" as AnyObject
        }else if param is NSNumber{
            let aString:String = "\(param!)"
            return aString as AnyObject
        }else if param is Double{
            return "\(String(describing: param))" as AnyObject
        }else{
            return param as AnyObject
        }
    }
    
    class func getVal(_ param:AnyObject!,typeObj:AnyObject) -> AnyObject {
        
        if param == nil{
            return typeObj
        }else if param is NSNull{
            return typeObj
        }else if param is NSNumber{
            return typeObj
        }else if param is Double{
            return typeObj
        }else{
            return typeObj
        }
        
    }
    class func saveinDefaults(_ responseData:[String:Any]){
        
        let _id = DataManager.getVal(responseData["_id"]) as? String ?? ""
        let address = DataManager.getVal(responseData["address"]) as? String ?? ""
        let allPatient = DataManager.getVal(responseData["allPatient"]) as? String ?? ""
        let createdAt = DataManager.getVal(responseData["createdAt"]) as? String ?? ""
        let dateOfBirth = DataManager.getVal(responseData["dateOfBirth"]) as? String ?? ""
        let doctorId = DataManager.getVal(responseData["doctorId"]) as? String ?? ""
        let email = DataManager.getVal(responseData["email"]) as? String ?? ""
        let lastName = DataManager.getVal(responseData["lastName"]) as? String ?? ""
        let mobile = DataManager.getVal(responseData["mobile"]) as? String ?? ""
        let firstName = DataManager.getVal(responseData["firstName"]) as? String ?? ""
        let ownPatient = DataManager.getVal(responseData["ownPatient"]) as? String ?? ""
        let ownPrescription = DataManager.getVal(responseData["ownPrescription"]) as? String ?? ""
        let role = DataManager.getVal(responseData["role"]) as? String ?? ""
        let status = DataManager.getVal(responseData["status"]) as? String ?? ""
        let password = DataManager.getVal(responseData["password"]) as? String ?? ""
        let addressId = DataManager.getVal(responseData["deliveryAddress"]) as? String ?? ""
//        let addID = DataManager.getVal(addressId["_id"]) as? String ?? ""
        
        //MARK:- Student Edit Profile
        Config().AppUserDefaults.set(_id, forKey: "_id")
        Config().AppUserDefaults.set(address, forKey: "address")
        Config().AppUserDefaults.set(allPatient, forKey: "allPatient")
        Config().AppUserDefaults.set(createdAt, forKey: "createdAt")
        Config().AppUserDefaults.set(dateOfBirth, forKey: "dateOfBirth")
        Config().AppUserDefaults.set(doctorId, forKey: "doctorId")
        Config().AppUserDefaults.set(email, forKey: "email")
        Config().AppUserDefaults.set(lastName, forKey: "lastName")
        Config().AppUserDefaults.set(mobile, forKey: "mobile")
        Config().AppUserDefaults.set(firstName, forKey: "firstName")
        Config().AppUserDefaults.set(ownPatient, forKey: "ownPatient")
        Config().AppUserDefaults.set(ownPrescription, forKey: "ownPrescription")
        Config().AppUserDefaults.set(role, forKey: "role")
        Config().AppUserDefaults.set(status, forKey: "status")
        Config().AppUserDefaults.set(password, forKey: "password")
        Config().AppUserDefaults.set(addressId, forKey: "_id")
        
        
        Config().AppUserDefaults.synchronize()
    }
    class func getValForIndex(_ arrayValues:AnyObject!,index:Int) -> AnyObject {
        
        ////print("getVal = \(arrayValues)")
        
        
        let arrayVal: AnyObject! = getVal(arrayValues)
        
        if arrayVal is NSArray || arrayVal is NSMutableArray
        {
            let arr = arrayValues as! NSArray
            if index < arr.count {
                return arr.object(at: index) as AnyObject
            }else{
                return "" as AnyObject
            }
        }
        else
        {
            return "" as AnyObject
        }
    }
    
    class func JSONStringify(_ value: AnyObject, prettyPrinted: Bool = false) -> String {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : []
        if JSONSerialization.isValidJSONObject(value) {
            if let data = try? JSONSerialization.data(withJSONObject: value, options: options) {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    
}

