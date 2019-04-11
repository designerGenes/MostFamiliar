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
    private var position: Int = 0
    private var xConstraint: NSLayoutConstraint?
    private var titleLabelDistConstraint: NSLayoutConstraint?
    
    public func getReaction() -> (() -> Void)? {
        return optionData?.reaction
    }
    
    public func loadData(optionData: SideCabinetOption, position: Int) {
        self.optionData = optionData
        icon.image = UIImage(named: optionData.assetName)
        titleLabel.text = optionData.title
        
        self.position = position
        xConstraint?.constant = -60 * (CGFloat(position) * 0.25)
        titleLabelDistConstraint?.constant = -60 - xConstraint!.constant
    }
    
    private func buildCell() {
        selectionStyle = .none
        let shellInnerView = UIView()
        for view in [shellView, icon, titleLabel, shellInnerView] {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(shellView)
        shellView.coverSelfEntirely(with: shellInnerView)
        shellInnerView.addSubview(icon)
        shellInnerView.addSubview(titleLabel)
        shellInnerView.layer.masksToBounds = true
        shellInnerView.layer.cornerRadius = 10
        shellInnerView.backgroundColor = UIColor.darkPurple().lighten(byPercentage: 0.3)
        shellView.backgroundColor = .clear
        backgroundColor = .clear
    
        
        titleLabel.font = UIFont.sfProDisplayBold(size: 32)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .right
        
        contentView.addConstraints([
            shellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shellView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            icon.trailingAnchor.constraint(equalTo: shellInnerView.trailingAnchor, constant: -16),
            icon.centerYAnchor.constraint(equalTo: shellInnerView.centerYAnchor),
            icon.heightAnchor.constraint(equalTo: shellInnerView.layoutMarginsGuide.heightAnchor, multiplier: 0.65),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: shellInnerView.centerYAnchor),
            ])
        
        titleLabelDistConstraint = titleLabel.trailingAnchor.constraint(equalTo: icon.leadingAnchor)
        titleLabelDistConstraint?.isActive = true
        xConstraint = shellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        xConstraint?.isActive = true
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
