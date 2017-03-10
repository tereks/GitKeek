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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.update()
    }
}
