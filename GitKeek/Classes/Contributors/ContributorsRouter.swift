//
//  ContributorsRouter.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class ContributorsRouter {
    
    class func controller() -> UINavigationController {
        
        let controller = ContributorsViewController()
        let navController = UINavigationController(rootViewController: controller)
        
        let presenter = ContributorsPresenter()
        let router = ContributorsRouter()
        let interactor = ContributorsInteractor()
        
        controller.presenter = presenter
        
        presenter.view = controller
        presenter.router = router
        presenter.interactor = interactor
        
        presenter.initialize()
        return navController
    }
    
    func openContributorScreen(nvc: UINavigationController, user: User) {
        let controller = SingleContributorRouter.controller(with: user)
        nvc.pushViewController(controller, animated: true)
    }
}
