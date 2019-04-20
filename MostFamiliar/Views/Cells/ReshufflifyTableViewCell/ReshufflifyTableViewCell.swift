//
//  ReshufflifyTableViewCell.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/20/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

protocol ReshufflifyTableViewCellDelegate: class {
    func didClickReload(in cell: ReshufflifyTableViewCell)
}

class ReshufflifyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var lblBumps: UILabel!
    weak var delegate: ReshufflifyTableViewCellDelegate?
    
    private var bumpCount: Int = 0 {
        didSet {
            lblBumps.text = "Bumps: \(bumpCount)"
        }
    }
    
    @IBAction func clickedReload(_ sender: UIButton) {
        delegate?.didClickReload(in: self)
    }
    
    func loadData(bumpCount: Int) {
        self.bumpCount = bumpCount
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadData(bumpCount: 0)
        backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        for view in [btnReload, lblBumps] {
            view!.layer.cornerRadius = view!.frame.height / 2
            view!.layer.masksToBounds = true
        }
        
    }
    
}
