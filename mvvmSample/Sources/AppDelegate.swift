//
//  AppDelegate.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var context: Context!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = .red

        let client = HTTPClient()

        let stack = CoreDataStack(modelName: "mvvmSample",
                                  type: .prod)
        context = Context(client: client, stack: stack)
        let screens = Screens(context: context)
        appCoordinator = AppCoordinator(appDelegate: self,
                                        context: context,
                                        screens: screens)
        appCoordinator?.start()
        return true
    }
}
