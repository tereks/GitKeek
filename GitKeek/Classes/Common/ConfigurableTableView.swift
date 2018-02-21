//
//  ConfigurableTableView.swift
//  GitKeek
//
//  Created by Sergey Kim on 11.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Cartography

class ConfigurableTableViewController<Cell: UITableViewCell>: UIViewController, UITableViewDataSource, 
UITableViewDelegate where Cell: Configurable {

    typealias DataType = Cell.DataType
    private let cellIdentifier = String(describing: Cell.self)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerReusableCell(Cell.self)
        tableView.rowHeight          = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.dataSource         = self
        tableView.delegate           = self
        return tableView
    }()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    var data = [DataType]() {
        didSet {
            refreshControl.endRefreshing()
            tableView.reloadData()
            if tableView.numberOfRows(inSection: 0) > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.tableView)
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        constrain(view, tableView) {
            superview, tableView in            
            tableView.edges == superview.edges
        }
        
        super.updateViewConstraints()
    }
    
    @objc func refreshPulled() {
        refreshControl.endRefreshing()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as Cell
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
