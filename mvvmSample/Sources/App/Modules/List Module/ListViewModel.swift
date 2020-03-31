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

    private var visibleQuote: [QuoteItem] = [] {
        didSet {
            guard !visibleQuote.isEmpty else {
                delegate?.displayAlert(for: .errorService)
                return }
            quoteItems?(visibleQuote)
        }
    }

    // MARK: - Initializer

    init(repository: RepositoryType, delegate: ListViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var labelText: ((String) -> Void)?

    var navBarTitle: ((String) -> Void)?

    var quoteItems: (([QuoteItem]) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        labelText?("Kanye West said:")
        navBarTitle?("List quotes")
    }

    func viewWillAppear() {
        getQuotes()
    }

    func getQuotes() {
        repository.getQuoteItems { [weak self] (items) in
            guard let self = self else { return }
            guard !items.isEmpty else {
                self.delegate?.displayAlert(for: .errorService)
                return
            }
            self.quoteItems?(items)
            self.visibleQuote = items
        }
    }

    // MARK: - Private Functions
}

//func getQuotes() {
//     if let item = UserDefaults.standard.object(forKey: "quoteItem") as? [String] {
//         print("getQuotes = \(item)")
//         //        visibleQuote.append(quote)
//     } else {
//         print("no quote yet")
//     }
// }
