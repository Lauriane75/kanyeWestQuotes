//
//  ThirdCoordinator.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 27/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class FavoriteCoordinator {

    // MARK: - Properties

    private let presenter: UINavigationController

    var childCoordinator: CoordinatorProtocol? = nil

    private let screens: Screens

    // MARK: - Initializer

    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
}

    // MARK: - CoordinatorProtocol

extension FavoriteCoordinator: CoordinatorProtocol {

    func start() {
        showThirdView()
    }

    private func showThirdView() {
        let viewController = screens.createThirdViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }

    private func showAlert(for type: AlertType) {
        let alert = screens.createAlertView(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension FavoriteCoordinator: FavoriteViewModelDelegate {
    func displayAlert(for type: AlertType) {
        showAlert(for: type)
    }
}

