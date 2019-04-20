//
//  ExamplesTableViewController+NightMode.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/12/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

extension ExamplesTableViewController: UsesDisplayColorMode {
    func dcmEnrolledViews() -> [(ColorRole, UIView)] {
//        let navigationBar = navigationController?.navigationBar as? UIView
        let out: [(ColorRole, UIView)] = [
            (.bodyFill, view),
            (.bodyFill, tableView),
        ]
        return out
    }
    
}
