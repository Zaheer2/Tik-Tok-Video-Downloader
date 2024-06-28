//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI
import UserNotifications

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner])
    }
}

struct Notification {
    let text: String
    let title: String
    
    public func execute() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { success, error in
            if success {
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = UNNotificationSound.default
                content.body = text
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func noURLProvided() {
        let errsNotif = Notification(text: "No URL Provided", title: "Error")
        errsNotif.execute()
    }
    
    static func videoDownloadWasSuccessful() {
        let succesNotif = Notification(text: "Video download was successful", title: "Info")
        succesNotif.execute()
    }
}
