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
    
    // TMP!
    
    private var examples = [ExampleData]()
    
    override init() {
        super.init()
        
        let exampleOne = ExampleData(title: "Side cabinet", subtitle: "There are never enough side cabinets", stinger: "Click here", hexColorString: "#9877B5", launchCallback: { vc in
            
        })
        
        let exampleTwo = ExampleData(title: "Google Places", subtitle: "Convert user input into 1 of over 100,000,000 autosuggested Google addresses.", stinger: "Connect now", hexColorString: "#64B8ED", launchCallback: { vc in
            vc.navigationController?.present(GooglePlacesViewController(), animated: true, completion: nil)
        })
        
        let exampleThree = ExampleData(title: "Local storage", subtitle: "Download that dishwasher manual that keeps going missing, and store it so its never lost again", stinger: "Fix that", hexColorString: "#B8E986", launchCallback: { vc in
            
        })
        
        let exampleFour = ExampleData(title: "Nested Navigation", subtitle: "Most apps are just navigation controllers nested within a tab bar controller.", stinger: "Get nesty", hexColorString: "#db5461", launchCallback: { vc in
            
        })
        
        let exampleFive = ExampleData(title: "Endless tableview", subtitle: "In about 5 billion years, even the sun will end.  A tableview with many items can make load times seem more endless than that.  This tableview is fast!", stinger: "Be amazed", hexColorString: "#2f195f", launchCallback: { (vc) in
            
        })
        
        examples = [exampleOne, exampleTwo, exampleThree, exampleFour, exampleFive]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typedCell = tableView.dequeueReusableCell(withIdentifier: "FamiliarExampleCell", for: indexPath) as? FamiliarExampleCell else {
            return UITableViewCell(frame: .zero)
        }
        typedCell.loadExample(idx: indexPath.section, exampleData: examples[indexPath.section])
        return typedCell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
