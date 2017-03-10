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
        let storyboard = UIStoryboard(name: R.Storyboard.Repos, bundle: nil)
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Wrong InitialViewController")
        }
        
        guard let controller = navController.topViewController as? ReposViewController else {
            fatalError("Wrong controller")
        }
        
        let presenter = ReposPresenter()
        let router = ReposRouter()
        let interactor = ReposInteractor()
        
        presenter.view = controller
        presenter.router = router
        presenter.interactor = interactor
        
        controller.presenter = presenter
        
        return navController
    }
    
    class func pushMainController(withNavigationController nvc: UINavigationController?) {
    }
}
