//
//  FavoriteViewController.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 27/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties

    var viewModel: FavoriteViewModel!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarCustom()

        bind(to: viewModel)

        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: FavoriteViewModel) {
        viewModel.labelText = { [weak self] text in
            self?.titleLabel.text = text
        }
    }

    // MARK: - View actions


    // MARK: - Private Files

    fileprivate func navigationBarCustom() {
        guard let bar = navigationController?.navigationBar else { return }
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple,
                              NSAttributedString.Key.font: UIFont(name: "kailasa", size: 20)]
        bar.titleTextAttributes = textAttributes as [NSAttributedString.Key: Any]

        viewModel.navBarTitle = { text in
            self.navigationItem.title = text
        }
    }

}
