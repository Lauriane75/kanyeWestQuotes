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

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties

    var viewModel: FavoriteViewModel!

    private lazy var collectionDataSource = FavoriteCollectionDataSource()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarCustom()

        collectionView.dataSource = collectionDataSource

        bind(to: viewModel)

        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
        
        bind(to: viewModel)
    }

    private func bind(to viewModel: FavoriteViewModel) {
        viewModel.favoriteItems = { [weak self] items in
          guard let self = self else { return }
            self.collectionDataSource.update(with: items)
            self.collectionView.reloadData()
        }
    }

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
