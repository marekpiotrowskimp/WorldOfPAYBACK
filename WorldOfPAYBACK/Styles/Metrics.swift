//
//  Metrics.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import Foundation

enum Metrics: CGFloat {
    case spacingOne = 4
    case spacingTwo = 8
    case spacingThree = 12
    case spacingFour = 16
    case spacingFive = 20
    case spacingSix = 24
    case spacingSeven = 28
    case spacingEight = 32
    case spacingNine = 36
    case spacingTen = 40
    
    var value: CGFloat {
        self.rawValue
    }
}
