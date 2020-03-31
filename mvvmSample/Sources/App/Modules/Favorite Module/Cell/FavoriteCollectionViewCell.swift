//
//  FavoriteCollectionViewCell.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 31/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlet

    @IBOutlet weak var favoriteQuoteLabel: UILabel!

    // MARK: - Configure

    func configure(with favoriteQuote: QuoteItem) {
        favoriteQuoteLabel.text = favoriteQuote.quote
      }

      override func prepareForReuse() {
          super.prepareForReuse()
          favoriteQuoteLabel.text = nil
      }

}
