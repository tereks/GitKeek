//
//  ReposInterface.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

protocol ReposInterface: Awaiting, Alarming {

    func reloadRepos()
    func setViewTitle(_ title: String)
    
}
