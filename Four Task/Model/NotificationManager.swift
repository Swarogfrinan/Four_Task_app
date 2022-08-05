//
//  NotificationManager.swift
//  Four Task
//
//  Created by Ilya Vasilev on 04.08.2022.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
let notificationCenter = UNUserNotificationCenter.current()
    
    func checkAuthorizationNotification() {
notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
    guard granted else { return }
    self.notificationCenter.getNotificationSettings { (settings) in
        print(settings)
        guard settings.authorizationStatus == .authorized else { return }
    }
}
}
    func sendNotificationToRelax() {
        
        let content = UNMutableNotificationContent()
        content.title = "Tomato task"
        content.body = "Фокус на концентрации завёршен, возьмите небольшой перерыв!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "NotificationToRelax", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription as Any)
        }
    }
    func sendNotificationToWork() {
        
        let content = UNMutableNotificationContent()
        content.title = "Tomato task"
        content.body = "Отдохнули? Продолжим работу!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "NotificationToWork", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription as Any)
        }
    }
    
}
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        print("Сработало уведомление не в бэкграунде")
    }
}
