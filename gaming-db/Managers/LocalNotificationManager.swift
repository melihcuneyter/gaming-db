//
//  LocalNotificationManager.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 16.01.2023.
//

import Foundation
import UserNotifications

protocol LocalNotificationManagerProtocol {
    func requestNotificationAuthorization()
    func sendNotification(title: String, desc: String)
}

final class LocalNotificationManager: LocalNotificationManagerProtocol {
    static let shared = LocalNotificationManager()
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    func requestNotificationAuthorization() {
        userNotificationCenter.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                self.userNotificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    guard error == nil && granted else {
                        print("User denied permissions, or error occurred")
                        return
                    }
                    print("permissions granted")
                }
            } else if settings.authorizationStatus == .denied {
                print("Notification permission was previously denied, go to settings & privacy to re-enable")
            } else if settings.authorizationStatus == .authorized {
                print("Notification permission was already granted")
            }
        })
    }
    
    func sendNotification(title: String, desc: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = desc
        
        let request = UNNotificationRequest(identifier: "FavoritesNotification", content: notificationContent, trigger: nil)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
