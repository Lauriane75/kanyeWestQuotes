//
//  SecondCoordinator.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class ListCoordinator {

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

extension ListCoordinator: CoordinatorProtocol {

    func start() {
        showSecondView()
    }

    private func showSecondView() {
        let viewController = screens.createSecondViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }

    private func showAlert(for type: AlertType) {
        let alert = screens.createAlertView(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension ListCoordinator: ListViewModelDelegate {
    func displayAlert(for type: AlertType) {
        showAlert(for: type)
    }
}
