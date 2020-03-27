//
//  FavoriteViewModel.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 27/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol FavoriteViewModelDelegate: class {
    func displayAlert(for type: AlertType)
}

final class FavoriteViewModel {

    // MARK: - Properties

    private let repository: RepositoryType

    private weak var delegate: FavoriteViewModelDelegate?

    // MARK: - Initializer

    init(repository: RepositoryType, delegate: FavoriteViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var labelText: ((String) -> Void)?

    var navBarTitle: ((String) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        labelText?("This is the favorite view")
        navBarTitle?("Favorite quotes")
    }

    // MARK: - Private Functions
}


