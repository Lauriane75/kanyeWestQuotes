//
//  Context.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

final class Context {

    let client: HTTPClientType
    let stack: CoreDataStack

    init(client: HTTPClientType, stack: CoreDataStack) {
        self.client = client
        self.stack = stack
    }
}
