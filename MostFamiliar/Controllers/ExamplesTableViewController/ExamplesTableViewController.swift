//
//  ExamplesTableViewController.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit
import SwiftSpinner

class ExamplesTableViewController: UIViewController, UITableViewDelegate {
    private let dataSource = ExamplesDataSource()
    
    // MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = dataSource
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SwiftSpinner.show("loading...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            SwiftSpinner.hide()
        })
    }

    
    // MARK: - UITableViewDelegate methods
}

