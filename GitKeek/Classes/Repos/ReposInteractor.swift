//
//  ReposInteractor.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import Foundation
import Promises

final class ReposInteractor {
    
    func loadRepositories() -> Promise<[Repo]> {
        return GithubService.shared.getRepos()
    }
    
}
