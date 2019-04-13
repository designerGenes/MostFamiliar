//
//  ExamplesDataSource.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

class ExamplesDataSource: NSObject, UITableViewDataSource {
    
    public func getData(for idx: Int) -> ExampleData? {
        guard idx >= 0 && idx < examples.count else {
            return nil
        }
        return examples[idx]
    }

    private var examples = [ExampleData]()
    
    override init() {
        super.init()
        
        let sideCabinetExample = ExampleData(title: "Side cabinet", subtitle: "There are never enough side cabinets", stinger: "Click here", hexColorString: "#9877B5", launchCallback: { vc in
            (vc as? ExamplesTableViewController)?.delegate?.setCabinetOpen(shouldOpen: true)
        })
        
        let spotifyExample = ExampleData(title: "Spotify integration", subtitle: "How can we make the world's best utility more useful?", stinger: "Hey listen", hexColorString: "#9877B5", launchCallback: { vc in
            (vc as? ExamplesTableViewController)?.delegate?.setCabinetOpen(shouldOpen: true)
        })
        
        let collectionViewExample = CollectionContainingExampleData(title: "Tableview within cell", subtitle: "Cells that go sideways and sideways and sideways.", stinger: "Swipe swipe", hexColorString: "#db5461", launchCallback: { vc in
            // none
        })
        
        let nightModeExample = ExampleData(title: "Night mode", subtitle: "Night mode, fighter of the day mode.  Champion of the moon!", stinger: "Work work!", hexColorString: "#B8E986", launchCallback: { vc in
            
        })

        let googlePlacesExample = ExampleData(title: "Google Places", subtitle: "Convert user input into 1 of over 100,000,000 autosuggested Google addresses.", stinger: "Connect now", hexColorString: "#64B8ED", launchCallback: { vc in
            (vc as? ExamplesTableViewController)?.navigationController?.pushViewController(GooglePlacesViewController(), animated: true)
            
        })

        let localStorageExample = ExampleData(title: "Local storage", subtitle: "Download that dishwasher manual that keeps going missing, and store it so its never lost again", stinger: "Fix that", hexColorString: "#B8E986", launchCallback: { vc in
            
        })
        
        let endlessTableViewExample = ExampleData(title: "Endless tableview", subtitle: "In about 5 billion years, even the sun will end.  A tableview with many items can make load times seem more endless than that.  This tableview is fast!", stinger: "Be amazed", hexColorString: "#2f195f", launchCallback: { (vc) in
            
        })
        
        examples = [sideCabinetExample, collectionViewExample, nightModeExample, localStorageExample, spotifyExample, googlePlacesExample, localStorageExample, endlessTableViewExample]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exampleData = examples[indexPath.section]
        let typedCell: UITableViewCell
        let actualRow = indexPath.section
        var id = "FamiliarExampleCell"
        switch exampleData {
        case is CollectionContainingExampleData:
            id = "FamiliarExampleCollectionContainingTableCell"
        default: break
        }
    
        typedCell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        // if normal
        (typedCell as? ContainsFamiliarExampleView)?.loadExample(coord: (0, actualRow + 1), exampleData: examples[actualRow])
        
        // if collection view container
        (typedCell as? FamiliarExampleCollectionContainingTableCell)?.loadCoord(coord: (0, actualRow + 1))
        return typedCell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
