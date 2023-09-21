//
//  Notifications.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/21.
//

import Foundation
import UserNotifications

struct NewsItem: Codable {
    let title: String
    let date: Date
    let link: String

    @discardableResult
    static func makeNewsItem(_ notification: [String: AnyObject]) -> NewsItem? {
        guard
            let news = notification["alert"] as? String,
            let url = notification["link_url"] as? String
        else {
            return nil
        }

        let newsItem = NewsItem(title: news, date: Date(), link: url)
        let newsStore = NewsStore.shared
        newsStore.add(item: newsItem)

        NotificationCenter.default.post(
            name: NewsFeedTableViewController.refreshNewsFeedNotification,
            object: self)

        return newsItem
    }
}

//class NotificationManager: UNUserNotificationCenterDelegate {
//    func isEqual(_ object: Any?) -> Bool {
//        <#code#>
//    }
//
//    var hash: Int
//
//    var superclass: AnyClass?
//
//    func `self`() -> Self {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func isProxy() -> Bool {
//        <#code#>
//    }
//
//    func isKind(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//
//    func isMember(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//
//    func conforms(to aProtocol: Protocol) -> Bool {
//        <#code#>
//    }
//
//    func responds(to aSelector: Selector!) -> Bool {
//        <#code#>
//    }
//
//    var description: String
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        completionHandler()
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .badge, .sound])
//    }
//}
