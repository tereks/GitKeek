//
//  SingleContributorPresenter.swift
//  GitKeek
//
//  Created by Sergey Kim on 22.02.2018.
//  Copyright © 2018 Sergey Kim. All rights reserved.
//

import Foundation

final class SingleContributorPresenter {
    
    weak var view: SingleContributorInterface!
    var router: SingleContributorRouter!
    
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func setup() {
        view.setViewTitle(user.login)
        if let avatarUrl = URL(string: user.avatarUrl) {
            view.setAvatarUrl(avatarUrl)
        }
        
        let attributedOwnerName = user.login.set(style: SRepoFormatter.medium)
        view.setUserName(attributedOwnerName)
    }
    
    func update() {
    }
}
