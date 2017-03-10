//
//  Awaiting.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import Foundation
import PKHUD

protocol Awaiting: class {
    func showHUD()
    func hideHUD()
}

extension Awaiting where Self: UIViewController {
    func showHUD() {
        HUD.show(.progress)
    }
    
    func hideHUD() {
        HUD.hide()
    }
}
