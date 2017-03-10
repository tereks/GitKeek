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
    
    func setup() {
    
    }
    
    func update() {
        DispatchQueue.once(token: "reload") {
            self.reload()
        }
    }
    
    func reload() {
        self.interactor.loadRepositories()
        .catch { error in
            self.view.hideHUD()
            self.view.showAlert(withTitle: S.error, message: error.localizedDescription)
        }
    }
}
