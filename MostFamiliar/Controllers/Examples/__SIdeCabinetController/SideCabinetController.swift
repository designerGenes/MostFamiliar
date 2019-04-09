//
//  SideCabinetController.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

typealias SideCabinetOption = (title:String, assetName: String, reaction: () -> Void)
class SideCabinetController: UIViewController {
    public enum CabinetState {
        case closed, open
    }
    
    private let tableView = UITableView()
    private var data = [SideCabinetOption]()
    public weak var delegate: HostsSideCabinet?
    public var state: CabinetState = .closed
    
    
    private func buildRow(cabinetOption: SideCabinetOption) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.brightRed()
        data = [
            ("Close sidebar", "", { self.delegate?.setCabinetOpen(shouldOpen: false) }),
            ("Un-open cabinet", "", { self.delegate?.setCabinetOpen(shouldOpen: false) }),
            ("About MostFamiliar", "", { self.delegate?.setCabinetOpen(shouldOpen: false) }),
        ]
        
        
        
//        view.coverSelfEntirely(with: tableView)
        
    }


}
