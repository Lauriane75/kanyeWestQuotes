//
//  Token.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

final class Token {

    init() {}

    deinit {
        willDealocate?()
    }

    var willDealocate:(() -> Void)?
}
