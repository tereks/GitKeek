//
//  Alarming.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

protocol Alarming: class {
    func showAlert(withTitle title: String, message: String)
}

extension Alarming where Self: UIViewController {
    
    func showAlert(withTitle title: String, message: String) {
        let okAction = UIAlertAction( title: S.ok, style: .default) { _ in
        }
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
