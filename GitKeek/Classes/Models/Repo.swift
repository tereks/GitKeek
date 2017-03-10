//
//  Repo.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Marshal

struct Repo: Unmarshaling {
    var id: Int
    var name: String
    var language: String
    var lastUpdate: Date
    
    init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        name = try object.value(for: "name")
        language = try object.value(for: "language")
        lastUpdate = try object.value(for: "updated_at")
    }
}
