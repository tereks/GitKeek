//
//  ReposRouter.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class ReposRouter {
    
    class func controller() -> UINavigationController {
        
        let controller = ReposViewController()
        let navController = UINavigationController(rootViewController: controller)
        
        let presenter = ReposPresenter()
        let router = ReposRouter()
        let interactor = ReposInteractor()
        
        controller.presenter = presenter
        
        presenter.view = controller
        presenter.router = router
        presenter.interactor = interactor
        
        return navController
    }
        
    func openRepoController(withNavigationController nvc: UINavigationController,
                            repo: Repo) {
        SRepoRouter.pushMainController(withNavigationController: nvc, repo: repo)
    }
}
