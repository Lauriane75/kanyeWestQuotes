//
//  SecondViewModel.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol ListViewModelDelegate: class {
    func displayAlert(for type: AlertType)
}

final class ListViewModel {

    // MARK: - Properties

    private let repository: RepositoryType

    private weak var delegate: ListViewModelDelegate?

    // MARK: - Initializer

    init(repository: RepositoryType, delegate: ListViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var labelText: ((String) -> Void)?

    var navBarTitle: ((String) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        labelText?("This is the list view")
        navBarTitle?("List quotes")
    }

    // MARK: - Private Functions
}

