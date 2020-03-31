//
//  Repository.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import CoreData

protocol RepositoryType: class {

    // MARK: - Get from API

    func getQuotes(callback: @escaping (Result<Quote>) -> Void, onError: @escaping (String) -> Void)

    // MARK: - Get from cache

    func getItem(item: QuoteItem)

    // MARK: - Save in coredata

    func saveQuoteItem(quoteItem: QuoteItem)

    func getQuoteItems(callback: @escaping ([QuoteItem]) -> Void)
}

enum DataFrom {
    case server
    case dataBase
}

final class Repository: RepositoryType {

    // MARK: - Properties

    private let context: Context
    private let token = Token()
    private let dataFrom: DataFrom

    private var quoteItems: [QuoteItem] = []

    // MARK: - Initializer

    init(context: Context, dataFrom: DataFrom) {
        self.context = context
        self.dataFrom = dataFrom
    }

    // MARK: - Get from API

    func getQuotes(callback: @escaping (Result<Quote>) -> Void, onError: @escaping (String) -> Void) {
        let stringUrl = "https://api.kanye.rest/"

        guard let url = URL(string: stringUrl) else { return }
        switch dataFrom {
        case .server:
            context.client.request(type: Quote.self,
                                   requestType: .GET,
                                   url: url,
                                   cancelledBy: token) { quote in

                                    switch quote {

                                    case .success(value: let quoteItem):
                                        let result: Quote = quoteItem
                                        callback(.success(value: result))
                                    case .error(error: let error):
                                        onError(error.localizedDescription)
                                    }
            }
        case .dataBase:
            print("from database")
            //            callback(.success(value: quoteItem))
        }
    }

    func getItem(item: QuoteItem) {
        quoteItems.append(item)
    }

    // MARK: - Save in coredata

    func saveQuoteItem(quoteItem: QuoteItem) {
        let quoteObject = QuoteObject(context: context.stack.context)
        quoteObject.quoteText = quoteItem.quote

        context.stack.saveContext()
    }

    // MARK: - Get from coredata

    func getQuoteItems(callback: @escaping ([QuoteItem]) -> Void) {
        let requestQuote: NSFetchRequest<QuoteObject> = QuoteObject.fetchRequest()
        guard let quoteItems = try? context.stack.context.fetch(requestQuote) else { return }
        let quote: [QuoteItem] = quoteItems.map { return QuoteItem(object: $0) }
        callback(quote)
    }

    // MARK: - Delete from coredata

}

extension QuoteItem {
    init(object: QuoteObject) {
        self.quote = object.quoteText ?? ""
    }
}
