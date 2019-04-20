//
//  ExamplesTableViewController.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit
import SwiftSpinner

class ExamplesTableViewController: UIViewController, UITableViewDelegate, SideCabinetHostDelegate {
    private let dataSource = ExamplesDataSource()
    weak public var delegate: HostsSideCabinet?
    
    // UsesDisplayColorMode methods
    
    
    // MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(FamiliarExampleCell.self, forCellReuseIdentifier: "FamiliarExampleCell")
        tableView.register(FamiliarExampleCollectionContainingTableCell.self, forCellReuseIdentifier: "FamiliarExampleCollectionContainingTableCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburgerMenu"), style: .plain, target: self, action: #selector(clickedOpenHamburgerMenu(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = .darkPurple()
        
        let darkModeSwitch = UISwitch()
        darkModeSwitch.onTintColor = .darkPurple()
        darkModeSwitch.addTarget(self, action: #selector(toggledDarkModeSwitch(sender:)), for: UISwitch.Event.valueChanged)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: darkModeSwitch)
    
        DisplayColorModeManager.registerForChangeNotification(registrant: self)
        
    }
    
    deinit {
        DisplayColorModeManager.deRegisterForChangeNotification(registrant: self)
    }

    @objc private func clickedOpenHamburgerMenu(sender: UIBarButtonItem) {
        delegate?.setCabinetOpen(shouldOpen: true)
    }

    @objc private func toggledDarkModeSwitch(sender: UISwitch) {
        let nightModeSwitch = navigationItem.leftBarButtonItem?.customView as! UISwitch
        DisplayColorModeManager.setGlobalDisplayColorMode(mode: nightModeSwitch.isOn ? .night : .regular)
    }
    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.getData(for: indexPath.section)?.launchCallback?(self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return FamiliarExampleCell.baseHeight
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
        return 56
    }
    
    
    // MARK: - SideCabinetHostDelegate methods
    func didSetCabinetOpen(cabinetHost: HostsSideCabinet, isOpen: Bool) {
        //
    }
}

