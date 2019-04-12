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

class FamiliarExampleCollectionContainingTableCell: FamiliarExampleCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let collectionView = UICollectionView()
    private var data = [ExampleData(title: "CollectionView within cell", subtitle: "Cells that go sideways and sideways and sideways.", stinger: "Swipe swipe", hexColorString: "#db5461")]
    
    // MARK: - UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FamiliarExampleCollectionViewCell", for: indexPath) as! FamiliarExampleCollectionViewCell
        cell.loadData(idx: indexPath.row, exampleData: data[indexPath.row])
        return cell
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

    
    override func addControls() {
        generateData()
        contentView.addSubview(collectionView)
        collectionView.register(FamiliarExampleCollectionViewCell.self, forCellWithReuseIdentifier: "FamiliarExampleCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

}
