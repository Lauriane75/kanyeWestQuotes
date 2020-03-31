//
//  AppCoordinator.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    
    private unowned var appDelegate: AppDelegate
    
    private let context: Context
    
    private var screens: Screens
    
    private var mainCoordinator: MainCoordinator
    
    // MARK: - Initializer
    
    init(appDelegate: AppDelegate, context: Context, screens: Screens, mainCoordinator: MainCoordinator) {
        self.appDelegate = appDelegate
        self.context = context
        self.screens = screens
        self.mainCoordinator = mainCoordinator
    }
}

// MARK: - CoordinatorProtocol

extension AppCoordinator {
    
    // MARK: - Start
    
    func start() {
        let tabBarController = mainCoordinator.tabBarController
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = tabBarController
        appDelegate.window!.makeKeyAndVisible()
        tabBarController.viewControllers = []
        
        // to stop running while testing
        if ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "YES" {
            return
        }
        mainCoordinator.createTabBar(tabBarController)
    }
}

