//
//  MainRouter.swift
//  GitKeek
//
//  Created by Sergey on 09.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class MainRouter {
    
    class func mainTabController() -> UITabBarController {
        let storyboard = UIStoryboard(name: R.Storyboard.Main, bundle: nil)
        guard let tabbarController = storyboard.instantiateInitialViewController() as? UITabBarController else {
            fatalError("Main Storyboard error")
        }
        return tabbarController
    }
    
    class func pushMainController(withNavigationController nvc: UINavigationController?) {
        nvc?.pushViewController(MainRouter.mainTabController(), animated: true)
    }
}
