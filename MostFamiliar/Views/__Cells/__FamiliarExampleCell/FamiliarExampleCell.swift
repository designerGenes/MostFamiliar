//
//  FamiliarExampleCell.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit
import ChameleonFramework

typealias IntCoord = (x: Int, y: Int)

protocol ContainsFamiliarExampleView: class {
    func loadExample(coord: IntCoord, exampleData: ExampleData)
}

class FamiliarExampleCell: UITableViewCell, ContainsFamiliarExampleView {
    private var exampleView: FamiliarExampleView?
    public static let baseHeight: CGFloat = 256
    public static let screenWidthMultiplier: CGFloat = 0.85
    
    func loadExample(coord: IntCoord, exampleData: ExampleData) {
        // vertical, only cares about row idx
        exampleView?.loadExample(idxString: "\(coord.y)", exampleData: exampleData)
    }

    
    func addControls() {
        let exampleView = FamiliarExampleView(cellContentView: contentView)
        self.exampleView = exampleView
        
        contentView.addSubview(exampleView)
        exampleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            exampleView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            exampleView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor),
            exampleView.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor),
            exampleView.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor, multiplier: FamiliarExampleCell.screenWidthMultiplier),
            ])
        
//        contentView.coverSelfEntirely(with: exampleView, obeyMargins: true, allowVerticalExtensionDown: true)
        
        selectionStyle = .none
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addControls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addControls()
    }

}
