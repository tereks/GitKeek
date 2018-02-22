//
//  SRepoPresenter.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import SwiftRichString

final class SRepoPresenter: DefaultPresenter {

    weak var view: SRepoInterface!
    var interactor: SRepoInteractor!
    var router: SRepoRouter!
    
    private var repo: Repo
    
    init(withRepo repo: Repo) {
        self.repo = repo
    }
    
    func setup() {
        self.view.setViewTitle(self.repo.name)
        if let avatarUrl = URL(string: self.repo.owner.avatarUrl) {
            self.view.setAvatarUrl(avatarUrl)
        }
        
        let attributedOwnerName = self.repo.owner.login.set(style: SRepoFormatter.medium)
        self.view.setOwnerName(attributedOwnerName)
        
        if let repoDesc = self.repo.desc {
            let attributed = repoDesc.set(style: SRepoFormatter.regular14)
            self.view.setRepoDescription(attributed)
        }
        self.view.setForks("\(self.repo.forksCount)")
        self.view.setWatchers("\(self.repo.watchersCount)")
    }
}
