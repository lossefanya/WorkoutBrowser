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
    let mainRouter = MainRouter(dependencyInjector: DependencyInjector.shared)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DependencyInjector.shared.registerDependencies()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainRouter.navigation
        self.window?.makeKeyAndVisible()
        mainRouter.start()
        return true
    }

}

