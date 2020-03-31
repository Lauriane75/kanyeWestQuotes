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

    private var favoritQuote: [QuoteItem] = [] {
         didSet {
             guard !favoritQuote.isEmpty else {
                 delegate?.displayAlert(for: .errorService)
                 return }
             favoriteItems?(favoritQuote)
         }
     }

    // MARK: - Initializer

    init(repository: RepositoryType, delegate: FavoriteViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var labelText: ((String) -> Void)?

    var navBarTitle: ((String) -> Void)?

    var favoriteItems: (([QuoteItem]) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        navBarTitle?("Favorite quotes")
        getFavoriteQuotes()
    }

    func viewWillAppear() {
         getFavoriteQuotes()
     }

    // MARK: - Private Functions

    private func getFavoriteQuotes() {
        repository.getFavoriteItems { [weak self] items in
            print(items)
            guard let self = self else { return }
            guard !items.isEmpty else {
                self.delegate?.displayAlert(for: .noQuote)
                return
            }
            self.favoriteItems?(items)
            self.favoritQuote = items
        }
    }
}


