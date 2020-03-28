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
    // MARK: - Save in coredata


    // MARK: - Get from coredata


    // MARK: - Delete from coredata

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

    // MARK: - Save in coredata

    // MARK: - Get from coredata

    // MARK: - Delete from coredata

}
