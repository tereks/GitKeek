//
//  CollectionCell.swift
//  GitKeek
//
//  Created by Sergey Kim on 22.05.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

protocol CollectionCell: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension CollectionCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static var nib: UINib? { return nil }
}
