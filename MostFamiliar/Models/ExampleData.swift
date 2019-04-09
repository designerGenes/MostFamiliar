//
//  ExampleData.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation

class ExampleData: NSObject {
    let hexColorString: String
    let title: String
    let subtitle: String
    let stinger: String?
    
    init(title: String, subtitle:String, stinger: String?, hexColorString: String) {
        self.title = title
        self.subtitle = subtitle
        self.stinger = stinger
        self.hexColorString = hexColorString
    }
}
