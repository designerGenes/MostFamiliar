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
    // TMP!
    private let exampleOne = ExampleData(title: "Side cabinet", subtitle: "There are never enough side cabinets", stinger: "Click here", hexColorString: "#9877B5")
    
    
    
    private let exampleTwo = ExampleData(title: "Google Places", subtitle: "Convert user input into 1 of over 100,000,000 autosuggested Google addresses.", stinger: "Connect now", hexColorString: "#B8E986")
    
    private let exampleThree = ExampleData(title: "Local storage", subtitle: "Download that dishwasher manual that keeps going missing, and store it so its never lost again", stinger: "Fix that", hexColorString: "#B8E986")
    
    private let exampleFour = ExampleData(title: "Nested Navigation", subtitle: "Most apps are just navigation controllers nested within a tab bar controller.", stinger: "Get nesty", hexColorString: "#B8E986")
    
    private let exampleFive = ExampleData(title: "Endless tableview", subtitle: "In about 5 billion years, even the sun will end.  A tableview with many items can make load times seem more endless than that.  This tableview is fast!", stinger: "Be amazed", hexColorString: "#B8E986")
    
    private var examples = [ExampleData]()
    
    override init() {
        super.init()
        examples = [exampleOne, exampleTwo, exampleThree, exampleFour, exampleFive]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typedCell = tableView.dequeueReusableCell(withIdentifier: "FamiliarExampleCell", for: indexPath) as? FamiliarExampleCell else {
            return UITableViewCell(frame: .zero)
        }
        typedCell.loadExample(idx: indexPath.row, exampleData: examples[indexPath.row])
        return typedCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
}
