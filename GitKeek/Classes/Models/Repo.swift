//
//  Repo.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Marshal

protocol RepoPresentable {
    var id: Int { set get }
    var name: String { set get }
    var language: String { set get }
    var lastUpdate: Date { set get }
    var desc: String? { set get }
    
    var forksCount: Int { set get }
    var stargazersCount: Int { set get }
    var watchersCount: Int { set get }
    
    var owner: User { set get }
}

struct Repo: Unmarshaling, RepoPresentable {
    var id: Int
    var name: String
    var language: String
    var lastUpdate: Date
    
    var forksCount: Int
    var stargazersCount: Int
    var watchersCount: Int
    
    var desc: String?
    var owner: User
    
    init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        name = try object.value(for: "name")
        language = try object.value(for: "language")
        lastUpdate = try object.value(for: "updated_at")
        
        forksCount = try object.value(for: "forks_count")
        stargazersCount = try object.value(for: "stargazers_count")
        watchersCount = try object.value(for: "watchers_count")

        desc = try? object.value(for: "description")
        owner = try object.value(for: "owner")
    }
}
