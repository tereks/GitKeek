//
//  ContributorsPresenter.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class ContributorsPresenter {

    weak var view: ContributorsInterface!
    var interactor: ContributorsInteractor!
    var router: ContributorsRouter!
    
    var сontributors: [User]! {
        didSet {
            self.view.reloadContributors()
        }
    }
    
    func setup() {
        view.setViewTitle(R.L10.contributors)
        reload()
    }
    
    func update() {
    }
    
    func reload() {
        self.view.showHUD()
        
        self.interactor.loadContributors()
        .then { сontributors -> Void in
            self.view.hideHUD()
            self.сontributors = сontributors
        }
        .catch { error in
            self.view.hideHUD()
            self.view.showAlert(withTitle: S.error, message: error.localizedDescription)
        }
    }
}
