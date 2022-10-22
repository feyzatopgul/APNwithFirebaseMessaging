//
//  AppDelegate.swift
//  APNwithFBMessaging
//
//  Created by fyz on 10/22/22.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            guard success else {
                print(error!.localizedDescription)
                return
            }
            print("Succesfully registered for notifications")
        }
        application.registerForRemoteNotifications()
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate{
 
    //APNs will generate and register a token when a user grants permission for push notifications.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    // It gets called whenever you receive a notification while the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        processData(notification)
        completionHandler([[.banner, .sound]])
    }
    //It gets called when a user taps a notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        processData(response.notification)
        completionHandler()
    }
    //It is called when a notification arrives with a data to be fetched
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Notification received")
    }
    func processData(_ notification: UNNotification){
        let userInfo = notification.request.content.userInfo
        UIApplication.shared.applicationIconBadgeNumber = 0
        if let title = userInfo["title"] as? String,
           let description = userInfo["description"] as? String {
           print("title: \(title)")
           print("description: \(description)")
           let news = News(title: title, description: description)
           NewsFeed.shared.addNews(news: news)
        }
    }
}

extension AppDelegate: MessagingDelegate{
    //Whenever the app starts up or Firebase updates the token, Firebase will call the method to keep the app in sync with it.
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print("Token: \(token)")
        }
    }
}
