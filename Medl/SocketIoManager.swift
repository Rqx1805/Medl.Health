//
//  SocketIoManager.swift
//  HowLit
//
//  Created by Tarun Nagar on 04/09/18.
//  Copyright © 2018 Tarun Nagar. All rights reserved.
//

import UIKit
import SocketIO


class SocketIoManager: NSObject {
    
    static let sharedInstance = SocketIoManager()
    
    let manager : SocketManager
    var socket: SocketIOClient
    
    override init() {
     self.manager = SocketManager(socketURL: URL(string: "https://medl.me:17301")!, config: [.log(true), .compress])
        self.socket = manager.defaultSocket
        
    }
    
    func establishConnection() {
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            self.getChatMessageNew()
        }
        socket.on("currentAmount") {data, ack in
            guard let cur = data[0] as? Double else { return }
            
            self.socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                self.socket.emit("update", ["amount": cur + 2.50])
            }
            
            ack.with("Got your currentAmount", "dude")
        }
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
    func connectToServerWithRoom(nickname: String) {
        print(nickname)
        self.getChatMessage1()
     
        socket.emit("confirmpurchase", with: [nickname as AnyObject])
       // self.getChatMessage()
       
    }
    
    func getChatMessage() {
        
        socket.on("confirmpurchase") { ( dataArray, ack) -> Void in
            print(dataArray)
            //let dict =
            var sender_profile_id = String()
            var message = String()
            
            for i in 0..<dataArray.count {
                var dict = NSDictionary()
                dict = dataArray[i] as! NSDictionary
                sender_profile_id = DataManager.getVal(dict["_id"]) as? String ?? ""
                message = DataManager.getVal(dict["message"]) as? String ?? ""
            }
            
            let chatDict = NSMutableDictionary()
            chatDict.setObject(sender_profile_id, forKey: "_id" as NSCopying)
            chatDict.setObject(message, forKey: "message" as NSCopying)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationNameStudent"), object: chatDict, userInfo: nil)
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationNameStudent"), object: chatDict, userInfo: nil)
            
            print(dataArray)
            print(ack)
            //completionHandler( dataArray[0] as? [String: AnyObject])
        }
    }
    
    
    
    
    func getChatMessage1() {
        
        socket.on("checkorder") { ( dataArray, ack) -> Void in
            print(dataArray)
            //let dict =
            var sender_profile_id = String()
            var message = String()
            
            for i in 0..<dataArray.count {
                var dict = NSDictionary()
                dict = dataArray[i] as! NSDictionary
                sender_profile_id = DataManager.getVal(dict["_id"]) as? String ?? ""
                message = DataManager.getVal(dict["message"]) as? String ?? ""
            }
            
            let chatDict = NSMutableDictionary()
            chatDict.setObject(sender_profile_id, forKey: "_id" as NSCopying)
            chatDict.setObject(message, forKey: "message" as NSCopying)
            
            print(chatDict)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationNameStudent"), object: dataArray, userInfo: nil)
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationNameStudent"), object: chatDict, userInfo: nil)
            
            print(dataArray)
            print(ack)
            //completionHandler( dataArray[0] as? [String: AnyObject])
        }
    }

    
    
    func connectToServerWithSecondRoom(nickname: String) {
//        let new = nickname.replacingOccurrences(of: "[", with: "")
//        let new1 = new.replacingOccurrences(of: "]", with: "")
        print(nickname)
        var newdata = String()
        newdata = "[" + nickname + "]"
        print(newdata)
        self.getOrderMessage()
        socket.emit("declinepurchase", with: [newdata as AnyObject])
       
    }
    
    func connectToServerWiththirdRoom(nickname: String) {
            print(nickname)
            var newdata = String()
            newdata = "[" + nickname + "]"
            print(newdata)
            self.getOrderMessage()
            socket.emit("declinepurchase", with: [newdata as AnyObject])
            
    }
    
    func getOrderMessage() {
        socket.on("responsemsg") { ( dataArray, ack) -> Void in
            print(dataArray)
            //let dict =
            var sender_profile_id = String()
            var message = String()
//            for i in 0..<dataArray.count {
//                var dict = NSDictionary()
//                dict = dataArray[i] as! NSDictionary
//                sender_profile_id = DataManager.getVal(dict["_id"]) as? String ?? ""
//                message = DataManager.getVal(dict["message"]) as? String ?? ""
//            }
            
            let chatDict = NSMutableDictionary()
            chatDict.setObject(sender_profile_id, forKey: "_id" as NSCopying)
            chatDict.setObject(message, forKey: "message" as NSCopying)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationNameStudent3"), object: dataArray, userInfo: nil)
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationNameStudentnew"), object: dataArray, userInfo: nil)
            
            print(dataArray)
            print(ack)
            //completionHandler( dataArray[0] as? [String: AnyObject])
        }
    }
    
    func getChatMessageNew() {
        let typeIdArrayString = UserDefaults.standard.value(forKey: "iduser") as? String
        socket.on(typeIdArrayString!) { ( dataArray, ack) -> Void in
            print(dataArray)
           NotificationCenter.default.post(name: NSNotification.Name("SocketOnEvent"), object: nil)
        }
    }
    
    
    
    
    func sendMessage(withSender sender_id: String) {
//        var array = [Any]()
//        array.append(sender_id)
//        print(array)
        print(sender_id)
        let new = sender_id.replacingOccurrences(of: "[", with: "")
        let new1 = new.replacingOccurrences(of: "]", with: "")
        print(new1)
        socket.emit("message",with: [new1])
    }
    
}

