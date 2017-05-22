//
//  MainTabbarController.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = controllers()
    }
    
    private func controllers() -> [UIViewController] {
        let repos = ReposRouter.controller()        
        return [repos]
    }
}
