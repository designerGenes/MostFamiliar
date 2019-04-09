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
    private let coloredCircle = UIView()
    
    public func loadExample(idx: Int, exampleData: ExampleData) {
        indexLabel.text = "\(idx)"
        titleLabel.text = exampleData.title
        subtitleLabel.text = exampleData.subtitle
        stingerLabel.text = exampleData.stinger
        coloredCircle.backgroundColor = UIColor(hexString: exampleData.hexColorString)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for view in [indexLabel, titleLabel, subtitleLabel, stingerLabel, divider, coloredCircle] {
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        layer.masksToBounds = true
        layer.cornerRadius = 50 // TMP!
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 1
        
        layoutMargins = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        
        contentView.addConstraints([
            coloredCircle.centerXAnchor.constraint(equalTo: contentView.leadingAnchor),
            coloredCircle.centerYAnchor.constraint(equalTo: contentView.topAnchor),
            coloredCircle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            indexLabel.trailingAnchor.constraint(equalTo: coloredCircle.trailingAnchor),
            indexLabel.topAnchor.constraint(equalTo: coloredCircle.centerYAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor),
            divider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            divider.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 4),
            stingerLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stingerLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            contentView.bottomAnchor.constraint(equalTo: stingerLabel.bottomAnchor, constant: 16)
            ])
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
