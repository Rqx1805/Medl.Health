//
//  AppDelegate.swift
//  Medl
//
//  Created by mac-15 on 23/10/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    var defaults:UserDefaults!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = Config().AppWhiteColor
        defaults = UserDefaults.standard
        defaults.removeObject(forKey: "Array")
//        let defaults = UserDefaults.standard
//        if defaults.object(forKey: "isFirstTime") == nil {
//            defaults.set("No", forKey:"isFirstTime")
//             let vc = LoginNew(nibName: "LoginNew", bundle: nil)
//            self.window?.rootViewController = vc
//            self.window?.makeKeyAndVisible()
//        }
        
        UINavigationBar.appearance().tintColor = Config().AppNavBlueColor//193358
        UINavigationBar.appearance().barTintColor = Config().AppNavBlueColor

        var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font:Config().AppGlobalFont(18, isBold: false),NSAttributedString.Key.foregroundColor: Config().AppBlackColor]

        IQKeyboardManager.shared.enable = true
        Thread.sleep(forTimeInterval: 2.0)
        let LoginVal = Config().AppUserDefaults.object(forKey: "login") as? String
        if (UIDevice.current.userInterfaceIdiom == .pad){
            print("iPad")
            if LoginVal == "yes"{
                let nav1 = UINavigationController()
                let mainView = DashBoard_iPad(nibName: "DashBoard_iPad", bundle: nil)
                nav1.viewControllers = [mainView]
                self.window!.rootViewController = nav1
                self.window?.makeKeyAndVisible()

            }else{
                let defaults = UserDefaults.standard
                if defaults.object(forKey: "isFirstTime") == nil {
                    defaults.set("No", forKey:"isFirstTime")
                    let nav1 = UINavigationController()
                    let vc = LoginNew_iPad(nibName: "LoginNew_iPad", bundle: nil)
                    nav1.viewControllers = [vc]
                    self.window?.rootViewController = nav1
                    self.window?.makeKeyAndVisible()
                } else {
                let nav1 = UINavigationController()
                let mainView = LoginVC_iPod(nibName: "LoginVC_iPod", bundle: nil)
                nav1.viewControllers = [mainView]
                self.window!.rootViewController = nav1
                self.window?.makeKeyAndVisible()
                }
                
            }
        }else{
            print("iPhone")
            if LoginVal == "yes"{
                let nav1 = UINavigationController()
                let mainView = DashBoard(nibName: "DashBoard", bundle: nil)
                nav1.viewControllers = [mainView]
                self.window!.rootViewController = nav1
                self.window?.makeKeyAndVisible()
            }else{
                let defaults = UserDefaults.standard
                if defaults.object(forKey: "isFirstTime") == nil {
                    defaults.set("No", forKey:"isFirstTime")
                    let nav1 = UINavigationController()
                    let vc = LoginNew(nibName: "LoginNew", bundle: nil)
                    nav1.viewControllers = [vc]
                    self.window?.rootViewController = nav1
                    self.window?.makeKeyAndVisible()
                }else{
                let nav1 = UINavigationController()
                let mainView = LoginVC(nibName: "LoginVC", bundle: nil)
                nav1.viewControllers = [mainView]
                self.window!.rootViewController = nav1
                self.window?.makeKeyAndVisible()
                }
            }
        }
        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
        }
         
          application.registerForRemoteNotifications()
         
        
        
        return true
    }


    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
            Messaging.messaging().apnsToken = deviceToken
            Messaging.messaging().isAutoInitEnabled = true
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let deafults = UserDefaults.standard
        deafults.set(fcmToken, forKey: "Devicetoken")
        deafults.synchronize()
        print("Firebase registration token: \(fcmToken)")
    }
    
    func  application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("i am not available in simulator \(error)")
    }
    
    
    
    //MARK:- Click on notification click
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let userInfo = userInfo as! [String: Any]
        print(userInfo)
        //let type = DataManager.getVal(userInfo["type"]) as! String
        
    }
    private func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        //Handle the notification
        completionHandler(
            [UNNotificationPresentationOptions.alert,
             UNNotificationPresentationOptions.sound,
             UNNotificationPresentationOptions.badge])
    }
    
    //MARK:- Function will call when application in active state
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
        let userInfo = notification.request.content.userInfo as! [String: Any]
        print(userInfo)
        //let type = DataManager.getVal(userInfo["type"]) as! String
    }

    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
}

