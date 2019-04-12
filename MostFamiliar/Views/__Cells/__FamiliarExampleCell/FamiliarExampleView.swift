//
//  FamiliarExampleView.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/11/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class FamiliarExampleView: UIView {
    private let indexLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stingerLabel = UILabel()
    private let divider = UIView()
    private let coloredRim = UIView()
    
    convenience init(cellContentView: UIView) {
        self.init()
        addControls()
    }

    public func loadExample(idxString: String, exampleData: ExampleData) {
        indexLabel.text = idxString
        titleLabel.text = exampleData.title
        subtitleLabel.text = exampleData.subtitle
        stingerLabel.text = exampleData.stinger
        coloredRim.backgroundColor = UIColor(hexString: exampleData.hexColorString)
        
    }
    
    internal func addControls() {
//        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        for view in [coloredRim, indexLabel, titleLabel, subtitleLabel, stingerLabel, divider] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let topRimOfColoredRim = UIView()
        coloredRim.addSubview(topRimOfColoredRim)
        coloredRim.layer.masksToBounds = true
        topRimOfColoredRim.translatesAutoresizingMaskIntoConstraints = false
        topRimOfColoredRim.backgroundColor = UIColor.white.withAlphaComponent(0.14)
        coloredRim.addConstraints([
            topRimOfColoredRim.topAnchor.constraint(equalTo: coloredRim.topAnchor),
            topRimOfColoredRim.widthAnchor.constraint(equalTo: coloredRim.widthAnchor),
            topRimOfColoredRim.heightAnchor.constraint(equalToConstant: 8),
            ])

        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 16
        
        
        let topMargin: CGFloat = 32
        layoutMargins = UIEdgeInsets(top: topMargin, left: 16, bottom: topMargin * 2, right: 16)
        addConstraints([
            coloredRim.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: -topMargin),
            titleLabel.topAnchor.constraint(equalTo: coloredRim.bottomAnchor, constant: 16),
            divider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            stingerLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            stingerLabel.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: 16),
            
            coloredRim.leadingAnchor.constraint(equalTo: leadingAnchor),
            coloredRim.trailingAnchor.constraint(equalTo: trailingAnchor),
            coloredRim.heightAnchor.constraint(equalToConstant: 50),
            indexLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            indexLabel.centerYAnchor.constraint(equalTo: coloredRim.centerYAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            
            divider.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stingerLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            ])
        
        for widthLimitedView in [titleLabel, divider, subtitleLabel] {
            widthLimitedView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
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
}
