//
//  AppDelegate.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 16.12.2022.
//

import UIKit

import GoogleMaps
import GoogleMobileAds
import GoogleSignIn

import UserNotifications

import Firebase
import FirebaseAnalytics
import FirebaseMessaging
import FirebaseCore

import FBSDKCoreKit

import FacebookCore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let googleMapsApiKey = "AIzaSyBm3QElalx93GJGIVHg_Un3MI3p70l1n9E"
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else {return}
            self.notificationCenter.getNotificationSettings { (settings) in
                print(settings)
            }
        }
        
        configureFirebase(for: application)
        
        GMSServices.provideAPIKey(googleMapsApiKey)
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        window?.rootViewController = CustomNavigationController(rootViewController: CoursesController())
        sendNotifications()
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
          if error != nil || user == nil {
            // Show the app's signed-out state.
          } else {
            // Show the app's signed-in state.
          }
        }
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        var handled: Bool

        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
          return true
        }

        // Handle other custom URL types.

        // If not handled by this app, return false.
        return false
    }
    
    func sendNotifications(){
        let content = UNMutableNotificationContent()
        content.title = "User we're waiting for you"
        content.body = "Time to explore new places, onward to adventure!"
        
        var date = DateComponents()
        date.calendar = Calendar.current
        date.hour = 14
        date.minute = 08
        
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

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("DEBUG / PUSH NOTIFICATION / Firebase registration token \(fcmToken)")
    }
    
    private func configureFirebase(for application: UIApplication) {
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in})
        
        application.registerForRemoteNotifications()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceiveresponse")
        completionHandler()
    }
}

