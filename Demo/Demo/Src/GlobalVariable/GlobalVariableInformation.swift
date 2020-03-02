//
//  GlobalVariableInformation.swift
//  Demo
//
//  Created by Suhail on 19/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import Foundation
import UIKit

class GlobalVariableInformation {
    
    private static var globalVariableInformation : GlobalVariableInformation? = nil

    let fileName = "Response"
    let extensionType = "json"
    let craftDemoString = "Craft Demo"
    
    static func instance() -> GlobalVariableInformation {
        if (globalVariableInformation == nil) {
            globalVariableInformation = GlobalVariableInformation()
        }
        return globalVariableInformation!
    }
    
    private init() {}
}
