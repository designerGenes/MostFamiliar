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
        
        let exampleOne = ExampleData(title: "Side cabinet", subtitle: "There are never enough side cabinets", stinger: "Click here", hexColorString: "#9877B5", launchCallback: { vc in
            (vc as? ExamplesTableViewController)?.delegate?.setCabinetOpen(shouldOpen: true)
        })
        
//        let exampleTwo = CollectionContainingExampleData(title: "Tableview within cell", subtitle: "Cells that go sideways and sideways and sideways.", stinger: "Swipe swipe", hexColorString: "#db5461", launchCallback: { vc in
//            // none
//        })
        
        let exampleFour = ExampleData(title: "Google Places", subtitle: "Convert user input into 1 of over 100,000,000 autosuggested Google addresses.", stinger: "Connect now", hexColorString: "#64B8ED", launchCallback: { vc in
            (vc as? ExamplesTableViewController)?.navigationController?.pushViewController(GooglePlacesViewController(), animated: true)
            
        })
        
        let exampleThree = ExampleData(title: "Local storage", subtitle: "Download that dishwasher manual that keeps going missing, and store it so its never lost again", stinger: "Fix that", hexColorString: "#B8E986", launchCallback: { vc in
            
        })
        
        
        let exampleFive = ExampleData(title: "Endless tableview", subtitle: "In about 5 billion years, even the sun will end.  A tableview with many items can make load times seem more endless than that.  This tableview is fast!", stinger: "Be amazed", hexColorString: "#2f195f", launchCallback: { (vc) in
            
        })
        
        examples = [exampleOne, /* exampleTwo, */ exampleThree, exampleFour, exampleFive]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exampleData = examples[indexPath.section]
        let typedCell: UITableViewCell
        if type(of: exampleData) == CollectionContainingExampleData.self {
            typedCell = tableView.dequeueReusableCell(withIdentifier: "FamiliarExampleCollectionContainingTableCell", for: indexPath)
        } else {
            typedCell = tableView.dequeueReusableCell(withIdentifier: "FamiliarExampleCell", for: indexPath)
        }
        
        (typedCell as! ContainsFamiliarExampleView).loadExample(idx: indexPath.section + 1, exampleData: examples[indexPath.section])
        return typedCell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
