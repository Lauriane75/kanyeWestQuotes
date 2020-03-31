//
//  ListTableViewDataSource.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 29/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class ListTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    // MARK: Private properties

    private var quoteItems: [QuoteItem] = []

    var selectedCity: ((Int) -> Void)?

    var selectedCityToDelete: ((Int) -> Void)?

    // MARK: Public function

    func update(with items: [QuoteItem]) {
        self.quoteItems = items
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard quoteItems.count > indexPath.item else {
            return UITableViewCell() // Should be monitored
        }
        let visibleQuote = quoteItems[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.configure(with: visibleQuote)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < quoteItems.count else { return }
        selectedCity?(indexPath.row)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard indexPath.row < quoteItems.count else { return }
        quoteItems.remove(at: indexPath.row)
        selectedCityToDelete?(indexPath.row)
    }

}

