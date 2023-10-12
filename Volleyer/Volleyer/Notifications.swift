//
//  Notifications.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/21.
//

import Foundation
import UserNotifications

class NotificationManager {

    static let notifyDelegate = NotificationManager()

    func successNotificationContent(id: String) {
        FinderDataManager.sharedDataMenager.getUserByFirebaseId(id: id) { gotUser, err in
            if let error = err {
                // Handle the error
                print("Error: \(error)")
            } else if let gotUser = gotUser {
                // Use the gotUser
                let content = UNMutableNotificationContent()
                content.title = "有新的邀請"
                content.subtitle = "加場邀請"
                content.body = "\(gotUser.id) 寄送加場邀請給你"
                content.sound = UNNotificationSound.defaultCritical
                // Add an attachment to the notification content
                if let url = Bundle.main.url(forResource: "dune",
                                                withExtension: "png") {
                    if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                                        url: url,
                                                                        options: nil) {
                        content.attachments = [attachment]
                    }
                }

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { (error) in
                    if error != nil {
                        print("success Error")
                    } else {
                        print("success Success")
                    }
                }
                print("success notify")
            } else {
                // Handle the case where no matching document was found
                print("No matching document found")
            }
        }
    }
}
