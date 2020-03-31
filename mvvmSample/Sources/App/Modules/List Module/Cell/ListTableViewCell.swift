//
//  ListTableViewCell.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 29/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class ListTableViewCell: UITableViewCell {

    // MARK: - Outlet

    @IBOutlet weak var quoteLabel: UILabel!

    // MARK: - Configure

    func configure(with visibleQuote: QuoteItem) {
        quoteLabel.text = visibleQuote.quote
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        quoteLabel.text = nil
    }
}

