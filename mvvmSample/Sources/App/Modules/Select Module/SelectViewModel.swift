//
//  FirstViewModel.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol SelectViewModelDelegate: class {
    func displayAlert(for type: AlertType)
}

final class SelectViewModel {

    // MARK: - Properties

    private let repository: RepositoryType

    private weak var delegate: SelectViewModelDelegate?

    private var visibleQuote: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                guard self.visibleQuote != [] else { self.delegate?.displayAlert(for: .errorService); return}
                self.quoteLabel?(self.visibleQuote)
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

    var quoteLabel: (([String]) -> Void)?

    var isLoading: ((Bool) -> Void)?
    
    // MARK: - Input

    func viewDidLoad() {
        titleText?("What's the quote of the day ?")
        navBarTitle?("Select a quote")
        quoteButtonText?("Get quote")
    }

    // MARK: - Private Functions

    func didPressGetQuote() {
        isLoading?(true)
        self.repository.getQuotes(callback: { quote in
            self.isLoading?(false)
            switch quote {
            case .success(value: let quoteItem):
                self.visibleQuote = [quoteItem.quote]
            case .error:
                self.delegate?.displayAlert(for: .errorService)
            }
        }, onError: { [weak self] error in
            self?.delegate?.displayAlert(for: .errorService)
            return
        })
    }
}
