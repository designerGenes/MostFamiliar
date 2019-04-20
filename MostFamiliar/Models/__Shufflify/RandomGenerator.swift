//
//  RandomGenerator.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/20/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import SwiftRandom
import UIKit

class RandomGenerator: NSObject {
    enum RandomValueType {
        case trackName, artistName, playlistName, albumName
    }
    
    private static var generatedValues = [RandomValueType: [String]]()
    private static let concreteNouns = ["victory", "friend", "everything", "hero", "fault", "fireman", "girl", "lemon", "hurricane", "decision", "man", "night", "bus", "frequency", "zombie", "rhyme", "lake", "cannon", "talk", "city"]
    private static let articles = ["a", "the", "some"]
    private static let prepositions = ["about", "above", "around", "among", "amid", "over", "past", "since", "with", "without", "underneath", "during", "through"]
    private static let colorNames = ["blue", "red", "white", "gold", "green", "yellow", "pink", "gray"]
    private static let seasonNames = ["winter", "spring", "summer", "fall"]
    private static let modalVerbs = ["will", "should", "can", "might", "would", "shall", "must"]
    private static let actionVerbs = ["move", "dare", "disappear", "eat", "wonder", "sleep", "go"]
    
    private static func adverbForm(infinitive: String) -> String {
        var out = infinitive
        if out.last == "e" {
            out.removeLast()
        }
        if out.last == "t" && out[out.index(before: out.endIndex)] == "e" {
            out += "t"
        }
        out += "ing"
        return out
    }
    
    static func random(type: RandomValueType) -> String {
        var out = ""
        switch type {
        case .artistName:
            switch randomInt(upperBound: 3) {
            case 0: // city & colour
                out = "\(Randoms.randomFakeCity().split(separator: " ").first!) \(randomInt(upperBound: 1) > 0 ? "and" : "&") \(Randoms.randomColor().description)"
            case 1: // human name
                out = Randoms.randomFakeName()
            default: // plural of possessive
                out = "\(Randoms.randomFakeTag())'s of \(Randoms.randomFakeName().split(separator: " ").first!)"
            }

        case .trackName, .playlistName, .albumName:
            switch randomInt(upperBound: 2) {
            case 0: // full
                var parts = [articles, concreteNouns]
                if Randoms.randomBool() {
                    parts.append(prepositions)
                    parts.append(contentsOf: Randoms.randomBool() ? [prepositions, concreteNouns] : [concreteNouns])
                }
                out = parts.map({$0.randomElement()!}).joined(separator: " ")
            case 1:  // color & name
                out = "\(colorNames.randomElement()!.capitalized) \([concreteNouns, seasonNames].randomElement()!.randomElement()!)"
            default:  // name (modal) verb
                out = "\(Randoms.randomFakeName().split(separator: " ").first!) \(modalVerbs.randomElement()!) \(actionVerbs.randomElement()!)"
            }
        }
        
        var holder = generatedValues[type] ?? [String]()
        holder.append(out)
        generatedValues[type] = holder
        return out
    }
}
