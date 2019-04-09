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
    weak public var delegate: HostsSideCabinet?
    
    // MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(FamiliarExampleCell.self, forCellReuseIdentifier: "FamiliarExampleCell")
        tableView.showsVerticalScrollIndicator = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburgerMenu"), style: .plain, target: self, action: #selector(clickedOpenHamburgerMenu(sender:)))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    @objc private func clickedOpenHamburgerMenu(sender: UIBarButtonItem) {
        animateSideCabinet(shouldOpen: true)
    }
    
    
    private func animateSideCabinet(shouldOpen: Bool) {
        delegate?.toggleCabinetOpen()
    }

    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = dataSource.getData(for: indexPath.section) else {
            return
        }
        data.launchCallback?(self)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

