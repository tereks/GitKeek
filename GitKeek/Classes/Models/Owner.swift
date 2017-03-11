//
//  Owner.swift
//  GitKeek
//
//  Created by Sergey Kim on 11.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Marshal

protocol OwnerPresentable {
    var id: Int { set get }
    var login: String { set get }
    var avatarUrl: String { set get }
    var type: String { set get }
}

struct Owner: Unmarshaling, OwnerPresentable {
    var id: Int
    var login: String
    var avatarUrl: String
    var type: String
    
    init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        login = try object.value(for: "login")
        avatarUrl = try object.value(for: "avatar_url")
        type = try object.value(for: "type")
    }
}
