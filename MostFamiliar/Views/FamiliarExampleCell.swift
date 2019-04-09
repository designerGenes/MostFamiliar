//
//  FamiliarExampleCell.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit
import ChameleonFramework

class FamiliarExampleCell: UITableViewCell {
    private let indexLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stingerLabel = UILabel()
    private let divider = UIView()
    private let coloredRim = UIView()
    
    public func loadExample(idx: Int, exampleData: ExampleData) {
        indexLabel.text = "\(idx)"
        titleLabel.text = exampleData.title
        subtitleLabel.text = exampleData.subtitle
        stingerLabel.text = exampleData.stinger
        coloredRim.backgroundColor = UIColor(hexString: exampleData.hexColorString)
        
    }
    
    private func addControls() {

        for view in [coloredRim, indexLabel, titleLabel, subtitleLabel, stingerLabel, divider] {
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        selectionStyle = .none
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
        
        contentView.addConstraints([
            coloredRim.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coloredRim.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coloredRim.topAnchor.constraint(equalTo: contentView.topAnchor),
            coloredRim.heightAnchor.constraint(equalToConstant: 60),
            indexLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            indexLabel.centerYAnchor.constraint(equalTo: coloredRim.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: coloredRim.bottomAnchor, constant: 16),
            divider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            divider.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 4),
            stingerLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stingerLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: stingerLabel.bottomAnchor, constant: 32)
            ])
        
        for widthLimitedView in [titleLabel, divider, subtitleLabel] {
            widthLimitedView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        }
        
        for multilineLabel in [titleLabel, subtitleLabel] {
            multilineLabel.numberOfLines = 0
        }
        
        titleLabel.font = UIFont.filsonSoftBold(size: 24)
        subtitleLabel.font = UIFont.sfDisplayRegular(size: 14)
        indexLabel.font = UIFont.filsonSoftBold(size: 32)
        stingerLabel.font = UIFont.sfDisplayRegular(size: 22)
        indexLabel.textColor = .white
        indexLabel.textAlignment = .left
        divider.backgroundColor = .black
        
        divider.layer.cornerRadius = 3
        divider.layer.masksToBounds = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addControls()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addControls()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
