//
//  AppDelegate.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainRouter = MainRouter()

        // Set MainRouter's viewController as rootViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainRouter.navigation
        self.window?.makeKeyAndVisible()
        mainRouter.start()
        return true
    }

}

