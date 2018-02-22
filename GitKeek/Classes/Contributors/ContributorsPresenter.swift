//
//  ContributorsPresenter.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class ContributorsPresenter: DefaultPresenter {

    weak var view: ContributorsInterface!
    var interactor: ContributorsInteractor!
    var router: ContributorsRouter!
    
    var сontributors: [User]! {
        didSet {
            self.view.reloadContributors()
        }
    }
    
    func initialize() {
        view.setViewTitle(R.L10.contributors)
    }
    
    func setup() {
        reload()
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
    
    func openUser(indexPath: IndexPath) {
        guard let nvc = (self.view as! UIViewController).navigationController else {
            return
        }
        
        let сontributors = self.сontributors[indexPath.row]
        router.openContributorScreen(nvc: nvc, user: сontributors)
    }
}
