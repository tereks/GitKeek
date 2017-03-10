//
//  ReposViewController.swift
//  GitKeek
//
//  Created by Sergey on 09.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController, ReposInterface {

    var presenter: ReposPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
