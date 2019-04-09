//
//  SideCabinetController.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

typealias SideCabinetOption = (title:String, assetName: String, reaction: () -> Void)
class SideCabinetController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    public enum CabinetState {
        case closed, open
    }
    
    private let tableView = UITableView()
    private var data = [SideCabinetOption]()
    public weak var delegate: HostsSideCabinet?
    public var state: CabinetState = .closed
    private var lastSwipeX: CGFloat = 0
    private var panGestureRecognizer: UIPanGestureRecognizer?
    
    private var fakeBgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fakeBgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        fakeBgroundView.backgroundColor = .darkPurple()

        view.layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 0)
        
        data = [
            ("close", "heart", { self.delegate?.setCabinetOpen(shouldOpen: false) }),
            ("renew", "roundedArrowRect", { self.delegate?.setCabinetOpen(shouldOpen: false) }),
            ("about", "star", { self.delegate?.setCabinetOpen(shouldOpen: false) }),
        ]
        
        view.addSubview(fakeBgroundView)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SideCabinetOptionCell.self, forCellReuseIdentifier: "OptionCell")
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        view.addGestureRecognizer(panGestureRecognizer!)
        
        view.addConstraints([
            fakeBgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fakeBgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            fakeBgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            fakeBgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            ])
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! SideCabinetOptionCell
        cell.loadData(optionData: data[indexPath.section], position: indexPath.section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.section].reaction()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    @objc private func didSwipe(sender: UIPanGestureRecognizer) {
        

        switch sender.state {
        case .began:
            lastSwipeX = sender.location(in: view).x
        case .changed:
            let newLocation = sender.location(in: view).x
            if abs(lastSwipeX - newLocation) > ((view.frame.width - lastSwipeX ) / 2) {
                delegate?.setCabinetOpen(shouldOpen: newLocation > lastSwipeX)
                view.removeGestureRecognizer(panGestureRecognizer!)
            }
        case .ended: break
        default: break

        }
    }


}
