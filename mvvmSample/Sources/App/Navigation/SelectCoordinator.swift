//
//  FirstCoordinator.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class SelectCoordinator {

    // MARK: - Properties

    private let navigationController: UINavigationController

    var childCoordinator: CoordinatorProtocol? = nil

    private let screens: Screens

    // MARK: - Initializer

    init(presenter: UINavigationController, screens: Screens) {
        self.navigationController = presenter
        self.screens = screens
    }
}

    // MARK: - CoordinatorProtocol

extension SelectCoordinator: CoordinatorProtocol {

    func start() {
        showFirstView()
    }

    private func showFirstView() {
        let viewController = screens.createFirstViewController(delegate: self)
        navigationController.viewControllers = [viewController]
    }

    private func showAlert(for type: AlertType) {
        let alert = screens.createAlertView(for: type)
        navigationController.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}


extension SelectCoordinator: SelectViewModelDelegate {

    func displayAlert(for type: AlertType) {
        DispatchQueue.main.async {
        self.showAlert(for: type)
        }
    }
}
