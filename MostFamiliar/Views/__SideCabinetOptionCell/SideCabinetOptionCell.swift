//
//  SideCabinetOptionCell.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/9/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class SideCabinetOptionCell: UITableViewCell {
    private var shellView = UIView()
    private var icon: UIImageView = UIImageView()
    private var titleLabel = UILabel()
    private var optionData: SideCabinetOption?
    
    public func getReaction() -> (() -> Void)? {
        return optionData?.reaction
    }
    
    public func loadData(optionData: SideCabinetOption) {
        self.optionData = optionData
        icon.image = UIImage(named: optionData.assetName)
        titleLabel.text = optionData.title
    }
    
    private func buildCell() {
        for view in [shellView, icon, titleLabel] {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(shellView)
        shellView.addSubview(icon)
        shellView.addSubview(titleLabel)
        shellView.layer.shadowOpacity = 0.45
        shellView.layer.shadowOffset = CGSize(width: 5, height: 3)
        shellView.backgroundColor = .brightRed()
        
        titleLabel.font = UIFont.sfProDisplayBold(size: 32)
        titleLabel.textAlignment = .left
        
        contentView.addConstraints([
            shellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            icon.trailingAnchor.constraint(equalTo: shellView.layoutMarginsGuide.trailingAnchor),
            icon.centerYAnchor.constraint(equalTo: shellView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: shellView.centerYAnchor),
            ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildCell()
    }
    
}
