//
//  ContributorsViewController.swift
//  GitKeek
//
//  Created by Sergey on 09.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class ContributorsViewController: ConfigurableTableViewController<ContributorsTableCell<User>>, ContributorsInterface {

    var presenter: ContributorsPresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setup()        
        tableView.tableFooterView = UIView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
        presenter.update()
    }
    
    func setViewTitle(_ title: String) {
        self.title = title
        self.tabBarItem.title = title
    }
    
    func reloadContributors() {
        self.data = presenter.сontributors
    }
    
    override func refreshPulled() {
        presenter.reload()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
