//
//  AppDelegate.swift
//  Four Task
//
//  Created by Ilya Vasilev on 12.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    let notificationManager = NotificationManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        splashPresenter?.present()
        
        let delay: TimeInterval = 3
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
            }
        }
        notificationManager.notificationCenter.delegate = self
        return true
    }
}

