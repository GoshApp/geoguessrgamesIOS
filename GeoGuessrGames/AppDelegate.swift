//
//  AppDelegate.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 16.12.2022.
//

import UIKit
import GoogleMaps
import GoogleMobileAds
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let googleMapsApiKey = "AIzaSyBm3QElalx93GJGIVHg_Un3MI3p70l1n9E"
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else {return}
            self.notificationCenter.getNotificationSettings { (settings) in
                print(settings)
            }
        }
        
        GMSServices.provideAPIKey(googleMapsApiKey)
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        window?.rootViewController = CustomNavigationController(rootViewController: CoursesController())
        sendNotifications()
        return true
    }
    
    func sendNotifications(){
        let content = UNMutableNotificationContent()
        content.title = "User we're waiting for you"
        content.body = "Time to explore new places, onward to adventure!"
        
        var date = DateComponents()
        date.calendar = Calendar.current
        date.hour = 15
        date.minute = 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: "non", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            print("Error notification + \(error)")
        }
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


}

