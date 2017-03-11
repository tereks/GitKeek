//
//  ReposPresenter.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class ReposPresenter {

    weak var view: ReposInterface!
    var interactor: ReposInteractor!
    var router: ReposRouter!
    
    var repos: [Repo]! {
        didSet {
            self.view.reloadRepos()
        }
    }
    
    func setup() {
        self.view.setViewTitle(R.L10.repos)
    }
    
    func update() {
        DispatchQueue.once(token: "reload") {
            self.reload()
        }
    }
    
    func reload() {
        self.view.showHUD()
        
        self.interactor.loadRepositories()
        .then { repos -> Void in
            self.view.hideHUD()
            self.repos = repos
        }
        .catch { error in
            self.view.hideHUD()
            self.view.showAlert(withTitle: S.error, message: error.localizedDescription)
        }
    }
    
    func openSingleRepo(indexPath: IndexPath) {
        guard let nvc = (self.view as! UIViewController).navigationController else {
            return
        }
        
        let repo = self.repos[indexPath.row]
        
        self.router.openRepoController(withNavigationController: nvc, repo: repo)
    }
}
