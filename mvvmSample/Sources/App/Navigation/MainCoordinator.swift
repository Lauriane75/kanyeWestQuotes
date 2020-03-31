//
//  MainCoordinator.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 27/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol {
    func start()
}

class MainCoordinator {
    
    // MARK: - Properties
    
    private var screens: Screens
    
    let tabBarController = UITabBarController()
    
    var coordinators: [CoordinatorProtocol] = []
    
    // MARK: - Initializer
    
    init(screens: Screens) {
        self.screens = screens
    }
}

// MARK: - Creating tabs

extension MainCoordinator {
    
    func createTabBar(_ tabBarController: UITabBarController) {
        let selectItem = createNavigationController(withTitle: "Select", image: UIImage(systemName: "pencil.and.outline")!)
        let listItem = createNavigationController(withTitle: "List", image: UIImage(systemName: "list.bullet")!)
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


