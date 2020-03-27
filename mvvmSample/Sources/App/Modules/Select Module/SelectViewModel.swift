//
//  FirstViewModel.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

struct QuoteItem {
    let quote: String
}

protocol SelectViewModelDelegate: class {
    func displayAlert(for type: AlertType)
}

final class SelectViewModel {

    // MARK: - Properties

    private let repository: RepositoryType

    private weak var delegate: SelectViewModelDelegate?

    private var visibleQuote: [QuoteItem] = [] {
        didSet {
            DispatchQueue.main.async {
                guard !self.visibleQuote.isEmpty else { self.delegate?.displayAlert(for: .errorService); return}
                self.quoteItem?(self.visibleQuote)
            }
        }
    }

    // MARK: - Initializer

    init(repository: RepositoryType, delegate: SelectViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var titleText: ((String) -> Void)?

    var navBarTitle: ((String) -> Void)?

    var quoteButtonText: ((String) -> Void)?

    var quoteItem: (([QuoteItem]) -> Void)?

    var heartText: ((String) -> Void)?

    var isLoading: ((Bool) -> Void)?
    
    // MARK: - Input

    func viewDidLoad() {
        titleText?("What's the quote of the day ?")
        navBarTitle?("Select a quote")
        quoteButtonText?("Get quote")
        heartText?("Add this quote in my favorite")
    }

    // MARK: - Private Functions

    func didPressGetQuote() {
        isLoading?(true)
        self.repository.getQuotes(callback: { quote in
            self.isLoading?(false)
            switch quote {
            case .success(value: let quoteItem):
                self.initializeWeather(quoteItem: quoteItem)
            case .error:
                self.delegate?.displayAlert(for: .errorService)
            }
        }, onError: { [weak self] error in
            self?.delegate?.displayAlert(for: .errorService)
            return
        })
    }

    // MARK: - Private Functions

    private func initializeWeather(quoteItem: Quote) {
        let structVisibleQuote = QuoteItem(quote: quoteItem.quote)
        self.visibleQuote = [structVisibleQuote]
    }
}
