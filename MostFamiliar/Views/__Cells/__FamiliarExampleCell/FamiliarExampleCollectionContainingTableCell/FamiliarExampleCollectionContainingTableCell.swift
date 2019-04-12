//
//  FamiliarExampleCollectionContainingTableCell.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/11/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class CollectionContainingExampleData: ExampleData {
    // used for type recognition
}

// CONTAINS a collection view full of cells

class FamiliarExampleCollectionContainingTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var baseCoord: IntCoord = (0, 0) // bad code I know
    private var data = [ExampleData(title: "CollectionView within cell", subtitle: "Cells that go sideways and sideways and sideways.", stinger: "Swipe swipe", hexColorString: "#db5461")]
    
    func loadCoord(coord: IntCoord) {
        baseCoord = coord
    }
    
    // MARK: - UICollectionViewFlowDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
    // MARK: - UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FamiliarExampleCollectionViewCell", for: indexPath) as! FamiliarExampleCollectionViewCell
        cell.loadExample(coord: (indexPath.section, baseCoord.y), exampleData: data[indexPath.section])
        return cell
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addControls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addControls()
    }
    
    private func generateData(generatedRowCount: Int = 4) {
        if data.count > 1 {
            data = [data.removeFirst()]
        }
        guard generatedRowCount > 0 else {
            return
        }
        
        var randomColorString: String = ""
        for k in 0..<generatedRowCount {
            let potentialExistingColor = UIColor(hexString: randomColorString)
            let isFinalRow = k == generatedRowCount - 1
            let subtitle = !isFinalRow ? "Cells that go sideways and sideways and sideways..." : "...until they abruptly stop."
            let stinger = isFinalRow ? "Swipe back" : "Swipe swipe"
            randomColorString = UIColor.randomProjectColor(notColor: potentialExistingColor).hexValue()
            data.append(ExampleData(title: "cell \(k)", subtitle: subtitle, stinger: stinger, hexColorString: randomColorString))
        }
    }

    
    
    func addControls() {
        generateData(generatedRowCount: 3)
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: FamiliarExampleCell.baseHeight), collectionViewLayout: flowLayout)
        collectionView.contentSize = CGSize(width: 20000, height: 2000)
        collectionView.showsHorizontalScrollIndicator = false
        
        coverSelfEntirely(with: collectionView, obeyMargins: true, allowVerticalExtensionDown: true)
        collectionView.heightAnchor.constraint(equalToConstant: FamiliarExampleCell.baseHeight).isActive = true
        collectionView.register(FamiliarExampleCollectionViewCell.self, forCellWithReuseIdentifier: "FamiliarExampleCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        selectionStyle = .none
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
    }

}
