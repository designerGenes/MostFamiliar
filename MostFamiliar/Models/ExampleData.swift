//
//  ExampleData.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

typealias LaunchCallack = ((UIViewController) -> Void)
class ExampleData: NSObject {
    let hexColorString: String
    let title: String
    let subtitle: String
    let stinger: String?
    let launchCallback: LaunchCallack?
    
    init(title: String, subtitle:String, stinger: String?, hexColorString: String, launchCallback: LaunchCallack?) {
        self.title = title
        self.subtitle = subtitle
        self.stinger = stinger
        self.hexColorString = hexColorString
        self.launchCallback = launchCallback
    }
}
