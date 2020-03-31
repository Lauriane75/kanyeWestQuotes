//
//  Screens.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class Screens {

    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))

    private let context: Context

    init(context: Context) {
        self.context = context
    }
}

// MARK: - First

extension Screens {
    func createFirstViewController(delegate: SelectViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier:
            "SelectViewController") as! SelectViewController
        let repository = Repository(context: context, dataFrom: .server)
        let viewModel = SelectViewModel(repository: repository,
                                        delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Second

extension Screens {
    func createSecondViewController(delegate: ListViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier:
            "ListViewController") as! ListViewController
        let repository = Repository(context: context, dataFrom: .dataBase)
        let viewModel = ListViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Third

extension Screens {
    func createThirdViewController(delegate: FavoriteViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier:
            "FavoriteViewController") as! FavoriteViewController
        let repository = Repository(context: context, dataFrom: .dataBase)
        let viewModel = FavoriteViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Alert

extension Screens {
    func createAlertView(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertViewController = UIAlertController(title: alert.title,
                                                    message: alert.message,
                                                    preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertViewController.addAction(action)
        return alertViewController
    }
}
