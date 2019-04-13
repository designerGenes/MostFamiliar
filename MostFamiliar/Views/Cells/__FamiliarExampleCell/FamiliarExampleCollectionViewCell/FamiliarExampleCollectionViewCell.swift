//
//  FamiliarExampleCollectionViewCell.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/11/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class FamiliarExampleCollectionViewCell: UICollectionViewCell, ContainsFamiliarExampleView {
    var exampleView: FamiliarExampleView?
    
    func loadExample(coord: IntCoord, exampleData: ExampleData) {
        exampleView?.loadExample(idxString: "\(coord.y).\(coord.x)", exampleData: exampleData)
    }
    
    private func linkControls() {
        let exampleView = FamiliarExampleView(cellContentView: contentView)
        self.exampleView = exampleView
        addSubview(exampleView)
        exampleView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            exampleView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            exampleView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            exampleView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            ])
        
        let weakAnchor = exampleView.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor)
        weakAnchor.priority = .defaultLow
        weakAnchor.isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        linkControls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        linkControls()
    }
}
