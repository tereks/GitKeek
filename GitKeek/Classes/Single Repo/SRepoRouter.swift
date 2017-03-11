//
//  SRepoRouter.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class SRepoRouter {
    
    class func controller(withRepo repo: Repo) -> SRepoViewController {
        
        let controller = SRepoViewController()
        
        let presenter = SRepoPresenter(withRepo: repo)
        let router = SRepoRouter()
        let interactor = SRepoInteractor()
        
        controller.presenter = presenter
        
        presenter.view = controller
        presenter.router = router
        presenter.interactor = interactor
        
        return controller
    }
    
    class func pushMainController(withNavigationController nvc: UINavigationController,
                                  repo: Repo) {
        let controller = SRepoRouter.controller(withRepo: repo)
        nvc.pushViewController(controller, animated: true)
    }
}
