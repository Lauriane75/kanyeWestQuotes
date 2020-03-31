//
//  SecondViewController.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    var viewModel: ListViewModel!

    private var source = ListTableViewDataSource()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarCustom()

        tableView.delegate = source
        tableView.dataSource = source

        bind(to: viewModel)

        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()

        bind(to: viewModel)
    }

    private func bind(to viewModel: ListViewModel) {
        viewModel.labelText = { [weak self] text in
            self?.titleLabel.text = text
        }
        viewModel.quoteItems = { [weak self] items in
            self?.source.update(with: items)
            self?.tableView.reloadData()
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
