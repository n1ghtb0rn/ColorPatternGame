//
//  MyUIButton.swift
//  ColorPatternGame
//
//  Created by Daniel Falkedal on 2022-02-01.
//

import Foundation
import UIKit

class MyUIButton: UIButton {
    
    private var colorIndex: Int = 0
    
    var y: Int = 0
    var x: Int = 0
    
    public func incrementColorIndex(max maxIndex: Int) {
        colorIndex += 1
        
        if colorIndex > maxIndex {
            colorIndex = 0
        }
    }
    
    public func getColorIndex() -> Int {
        return colorIndex
    }
    
}
