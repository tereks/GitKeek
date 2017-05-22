//
//  Configurable.swift
//  GitKeek
//
//  Created by Sergey Kim on 11.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import Foundation

protocol Configurable: CollectionCell {
    associatedtype DataType: Any
    func config(withData data: DataType)
}
