//
//  NightMode.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/12/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import SwiftSpinner

typealias RoleColorTuple = (role: ColorRole, color: UIColor)
typealias RoleColorSheet = [ColorRole: UIColor]

enum ColorRole {
    case headerFill // may contain title-style uniquely-colored text but not body text
    case headerText // if headerFill is a color which doesn't support black contract, use white
    case bodyFill // what would be solid white in a MS Word document
    case bodyText // default color for text containing explanation of title
    case navigationHeaderFill // nav bar bground color
    case navigationHeaderRightButtonItem
    case navigationHeaderLeftButtonItem
}

enum DisplayColorMode: String {
    // for this demo we assume the user always begins in day mode.
    // this could easily change
    case regular, night
    func notificationName() -> String {
        switch self {
        case .regular: return "DG_DCM_ACTIVATE_REGULAR_DCM_NOTIFICATION"
        case .night: return "DG_DCM_ACTIVATE_NIGHT_DCM_NOTIFICATION"
        }
    }
}

protocol UsesDisplayColorMode: class {
    func dcmEnrolledViews() -> [(ColorRole, UIView)]
//    func setDisplayColorMode(mode: DisplayColorMode)
}

extension UsesDisplayColorMode {
    func applyDisplayColorSheet(colorSheet: RoleColorSheet) {
        // this is only the default implementation
        for (role, view) in dcmEnrolledViews() {
            switch role {
            case .headerFill, .bodyFill, .navigationHeaderFill:
                view.backgroundColor = colorSheet[role]
            case .bodyText, .headerText:
                (view as? UILabel)?.textColor = colorSheet[role]
                (view as? UITextView)?.textColor = colorSheet[role]
            default: break
                
            }
        }
    }
}


class DisplayColorModeManager: NSObject {
    private static var colorMode: DisplayColorMode = .regular
    private static var colorModeChangeListeners = Set<NSObject>()  // should conform to UsesDisplayColorMode
    private static var defaultColorSheets = [NSObject: [RoleColorTuple]]()
    
    static func getColorMode() -> DisplayColorMode {
        return DisplayColorMode(rawValue: colorMode.rawValue)!
    }

    private static func createColorSheet(from roleViewMap: [ColorRole: UIView]) -> RoleColorSheet {
        // assimilate roleViewMap and return sheet
        
        var out = RoleColorSheet()
        for (role, view) in roleViewMap {
            switch role {
            case .bodyFill, .headerFill, .navigationHeaderFill:
                out[role] = view.backgroundColor
            case .bodyText, .headerText:
                out[role] = (view as? UILabel)?.textColor ?? (view as? UITextView)?.textColor
            default: break  // TBC...
            }
        
        }
        return out
    }
    
    static func registerForChangeNotification(registrant: NSObject) {
        guard !colorModeChangeListeners.contains(registrant), let typedRegistrant = registrant as? UsesDisplayColorMode else {
            return
        }
        colorModeChangeListeners.insert(registrant)
//        defaultColorSheets[registrant] = createColorSheet(from: typedRegistrant.dcmEnrolledViews())  // default is starting state
    }
    
    static func deRegisterForChangeNotification(registrant: NSObject) {
        colorModeChangeListeners.remove(registrant)
        defaultColorSheets[registrant] = nil
    }
    
    
    
    static func setGlobalDisplayColorMode(mode: DisplayColorMode) {
        SwiftSpinner.show("Applying")
//        for untyped in colorModeChangeListeners {
//            let nightModeColorSheet = makeColorSheet(for: .night, from: defaultColorSheets[untyped]!)
//            let typed = untyped as! UsesDisplayColorMode
//            let colorSheet = mode == .regular ? defaultColorSheets[untyped]! : nightModeColorSheet
//            typed.applyDisplayColorSheet(colorSheet: colorSheet)  // temporary since we have only 2 modes
//        }
//
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            SwiftSpinner.hide() // primitive
        }
    }
    
    private static func makeColorSheet(for mode: DisplayColorMode, from sheet: RoleColorSheet) -> RoleColorSheet {
        guard mode == .night else {
            return sheet  // for now
        }
        
        var sheet = sheet
        var newColor: UIColor?
        for (role, color) in sheet {
            switch role {
            case .bodyText, .headerText:
                newColor = UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: true)
            case .bodyFill, .headerFill, .navigationHeaderFill:
                newColor = color.darken(byPercentage: 0.8)
            default: break
            }
            sheet[role] = newColor
        }
        
        return sheet
    }
    
    static func setNightMode(isOn: Bool) {
        setGlobalDisplayColorMode(mode: isOn ? .night : .regular)
    }
    
}
