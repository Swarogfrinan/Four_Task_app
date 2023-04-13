import Foundation
import UserNotifications

final class NotificationManager {
    
    //MARK: - Properties
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    //MARK: - Public Methods
    
    func checkAuthorizationNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                print(settings)
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }
    ///Отправить уведомление юзеру что "Фокус" закончен.
  func sendNotificationToRelax() {
        
        let content = UNMutableNotificationContent()
        content.title = Constants.Notification.title
        content.body = Constants.Notification.bodyRelaxMessage
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: Constants.Notification.relaxIdentifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription as Any)
        }
    }
    ///Отправить уведомление юзеру что "Отдых" закончен.
   func sendNotificationToWork() {
        
        let content = UNMutableNotificationContent()
        content.title = Constants.Notification.title
        content.body = Constants.Notification.bodyWorkMessage
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: Constants.Notification.workIdentifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription as Any)
        }
    }
    
}
//MARK: -  AppDelegate

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    ///Нажатие на уведомление при открытом приложении.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        print(Constants.Notification.touchNotificationInAppb)
    }
}

// MARK: - Constants

private extension Constants {
    struct Notification {
        static let title = "Tomato task"
        static let bodyWorkMessage = "Фокус на концентрации завёршен, возьмите небольшой перерыв!"
        static let bodyRelaxMessage = "Отдохнули? Вернитесь в приложение чтобы продолжить"
        static let workIdentifier = "NotificationToWork"
        static let relaxIdentifier = "NotificationToRelax"
        static let touchNotificationInApp = "Сработало уведомление не в бэкграунде"
    }
}
