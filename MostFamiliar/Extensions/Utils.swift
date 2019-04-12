//
//  Utils.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/11/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation


func randomInt(upperBound: Int, min: Int = 0) -> Int {
    guard min < upperBound else {
        return -1
    }
    let availableInts = Array(min..<upperBound)
    return availableInts[Int(arc4random_uniform(UInt32(availableInts.count)))]
}
