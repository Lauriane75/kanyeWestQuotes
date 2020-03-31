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
            self.visibleQuote.enumerated().forEach { _, index in
                UserDefaults.standard.set(index.quote, forKey: "quoteItem")
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

    func viewWillAppear() {
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
                if let item = UserDefaults.standard.object(forKey: "quoteItem") as? String {
                    let structQuoteItem = QuoteItem(quote: item)
                    self.visibleQuote = [structQuoteItem]
                }
            }
        }, onError: { [weak self] error in
            guard let self = self else { return }
            if let item = UserDefaults.standard.object(forKey: "quoteItem") as? String {
                guard item != "" else {
                    self.delegate?.displayAlert(for: .errorService)
                    return }
                let structQuoteItem = QuoteItem(quote: item)
                self.visibleQuote = [structQuoteItem]
            }
        })
    }

    // MARK: - Private Functions

    private func initializeWeather(quoteItem: Quote) {
        let structQuoteItem = QuoteItem(quote: quoteItem.quote)
        repository.getItem(item: structQuoteItem)
        repository.saveQuoteItem(quoteItem: structQuoteItem)
        visibleQuote = [structQuoteItem]
    }
}
