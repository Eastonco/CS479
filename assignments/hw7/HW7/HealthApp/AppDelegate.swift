//
//  AppDelegate.swift
//  HealthApp
//
//  Created by Connor Easton on 1/21/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert,.badge,.sound], completionHandler: {(granted, error) in
            
        })
        if (UserDefaults.standard.object(forKey: Constants.main.sortQuotesKey) == nil){
            UserDefaults.standard.setValue(false, forKey: Constants.main.sortQuotesKey)
        }
        if (UserDefaults.standard.object(forKey: Constants.main.showAuthorsKey) == nil){
            UserDefaults.standard.setValue(true, forKey: Constants.main.showAuthorsKey)
        }
        if (UserDefaults.standard.object(forKey: Constants.main.filterAnonKey) == nil){
            UserDefaults.standard.setValue(false, forKey: Constants.main.filterAnonKey)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("user responded to notification")
        
        let navVC = UIApplication.shared.windows.first!.rootViewController as! UINavigationController
        let vcs = navVC.viewControllers
        for vc in vcs{
            if let mainVC = vc as? HomeTableViewController{
                mainVC.handleNotification(response)
            }
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Received notifcation while in foreground")
        completionHandler([.banner])
    }

}

