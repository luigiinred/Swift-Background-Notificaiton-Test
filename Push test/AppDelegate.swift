//
//  AppDelegate.swift
//  Push test
//
//  Created by Timmy Garrabrant on 4/2/20.
//  Copyright © 2020 Timmy Garrabrant. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NSLog("PUSHTESTS: didFinishLaunchingWithOptions ")

        var i = 0
        if let launchOptions = launchOptions as? [String: AnyObject] {
            for (kind, value) in launchOptions {
                NSLog("PUSHTESTS: \(kind)")
                i+=1
            }
        }
                        NSLog("PUSHTESTS: \(i)")

        UNUserNotificationCenter.current().delegate = self
        registerForPushNotifications(application: application)
        getRegisteredPushNotifications()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_: UIApplication,
                     didReceiveRemoteNotification _: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NSLog(" PUSHTESTS: didReceiveRemoteNotification")
        
        completionHandler(UIBackgroundFetchResult.noData)
    }

     func userNotificationCenter(_ center: UNUserNotificationCenter,
                            willPresent notification: UNNotification,
                            withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        NSLog(" PUSHTESTS: userNotificationCenter")
        
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    func registerForPushNotifications(application:UIApplication) {
        UNUserNotificationCenter.current() // 1
            .requestAuthorization(options: [.alert, .sound, .badge]) { // 2
                granted, error in
                if granted {
                    DispatchQueue.main.async() {
                        UIApplication.shared.registerForRemoteNotifications()
                        NSLog(" PUSHTESTS: registerForRemoteNotifications")
                    }
                }
           
            }
        
    }
    
    // implemented in your application delegate
    private func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData!) {
        NSLog("Got token data!")
    }

    private func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError!) {
        NSLog("Couldn't register")
    }
    
    func getRegisteredPushNotifications() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            NSLog("Notification settings: \(settings)")
        }
    }
}
