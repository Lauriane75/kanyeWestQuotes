//
//  FavoriteCollectionDataSource.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 31/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class FavoriteCollectionDataSource: NSObject, UICollectionViewDataSource {

    // MARK: Private properties

    private var items: [QuoteItem] = []

    // MARK: Public function

    func update(with items: [QuoteItem]) {
        self.items = items
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard items.count > indexPath.item else {
            return UICollectionViewCell() // Should be monitored
        }
        let visibleQuote = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell",
                                                      for: indexPath)
            as! FavoriteCollectionViewCell
        cell.configure(with: visibleQuote)
        return cell
    }
}

