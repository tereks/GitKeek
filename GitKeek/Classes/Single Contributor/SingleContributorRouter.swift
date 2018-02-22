//
//  SingleContributorRouter.swift
//  GitKeek
//
//  Created by Sergey Kim on 22.02.2018.
//  Copyright © 2018 Sergey Kim. All rights reserved.
//

import UIKit

final class SingleContributorRouter {
    
    class func controller(with user: User) -> SingleContributorController {
        
        let storyboard = UIStoryboard(name: "Contributor", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SingleContributorController") as? SingleContributorController else {
            fatalError("SingleContributorController not in storyboard")
        }
        
        let presenter = SingleContributorPresenter(user: user)
        let router = SingleContributorRouter()
        
        controller.presenter = presenter
        
        presenter.view = controller
        presenter.router = router
        
        return controller
    }
}
