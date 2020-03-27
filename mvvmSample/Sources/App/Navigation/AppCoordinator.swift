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

    var coordinators: [CoordinatorProtocol] = []

    // MARK: - Initializer

    init(appDelegate: AppDelegate, context: Context, screens: Screens) {
        self.appDelegate = appDelegate
        self.context = context
        self.screens = screens
    }
}

// MARK: - CoordinatorProtocol

extension AppCoordinator {

    // MARK: - Start

    func start() {
        let tabBarController = UITabBarController()

        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = tabBarController
        appDelegate.window!.makeKeyAndVisible()
        tabBarController.viewControllers = []

        // to stop running while testing
        if ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "YES" {
            return
        }
        createTabBar(tabBarController)
    }
}


// MARK: - Creating tabs

extension AppCoordinator {

    fileprivate func createTabBar(_ tabBarController: UITabBarController) {
        let selectItem = createNavigationController(withTitle: "Select", image: UIImage(systemName: "star")!)
        let listItem = createNavigationController(withTitle: "List", image: UIImage(systemName: "heart")!)
        let favoriteItem = createNavigationController(withTitle: "Favorite", image: UIImage(systemName: "heart")!)


        let firstCoordinator = SelectCoordinator(presenter: selectItem, screens: screens)
        coordinators.append(firstCoordinator)
        firstCoordinator.start()

        let secondCoordinator = ListCoordinator(presenter: listItem, screens: screens)
        coordinators.append(secondCoordinator)
        secondCoordinator.start()

        let thirdCoordinator = FavoriteCoordinator(presenter: favoriteItem, screens: screens)
        coordinators.append(thirdCoordinator)
        thirdCoordinator.start()

        let rootViewControllers = [selectItem, listItem, favoriteItem]
        tabBarController.setViewControllers(rootViewControllers, animated: false)
    }

    func createNavigationController(withTitle title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false

        navController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)

        return navController
    }
}

