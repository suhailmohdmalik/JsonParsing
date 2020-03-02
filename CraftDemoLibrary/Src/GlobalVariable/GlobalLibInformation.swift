//
//  GlobalLibInformation.swift
//  CraftDemoLibrary
//
//  Created by Suhail on 20/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import Foundation
import UIKit

class GlobalLibInformation {
    
    private static var globalLibInformation : GlobalLibInformation? = nil

    var counterMaxValue = 20
    
    static func instance() -> GlobalLibInformation {
        if (globalLibInformation == nil) {
            globalLibInformation = GlobalLibInformation()
        }
        return globalLibInformation!
    }
    
    private init() {}
}

