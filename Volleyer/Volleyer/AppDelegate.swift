//
//  AppDelegate.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/13.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FirebaseApp.configure()
        let db = Firestore.firestore()

        var thisUser = UserData(id: "", email: "", gender: 99, name: "")

        db.collection("users").whereField("id", isEqualTo: "iamMandy").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    // swiftlint:disable force_cast
                    for document in querySnapshot!.documents {
                        thisUser = UserData(id: document.data()["id"] as! String,
                                            email: document.data()["email"] as! String,
                                            gender: document.data()["gender"] as! Int,
                                            name: document.data()["name"] as! String)
                        print("\(document.documentID) => \(document.data())")
                        print(thisUser)
                        // all strings
                        UserDefaults.standard.set(thisUser.id, forKey: User.id.rawValue)
                        UserDefaults.standard.set(thisUser.name, forKey: User.name.rawValue)
                        UserDefaults.standard.set(genderList[thisUser.gender], forKey: User.gender.rawValue)
                        DataManager.sharedDataMenager.listenPlayRequests()
//                        if launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] != nil {
//                            DataManager.sharedDataMenager.listenPlayRequests()
//                        }
                    }
                    // swiftlint:enable force_cast
                }
        }

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound]) { (granted, error) in
            if granted {
                print("允許開啟")
            } else {
                print("拒絕接受開啟")
            }
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


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
}
