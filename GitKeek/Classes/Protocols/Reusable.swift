//
//  Reusable.swift
//  GitKeek
//
//  Created by Sergey Kim on 11.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import Foundation

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
