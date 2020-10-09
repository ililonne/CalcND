//
//  ActionType.swift
//  CalcND
//
//  Created by mst on 09.10.2020.
//  Copyright © 2020 mst. All rights reserved.
//

import Foundation

enum ActionType {
    case zero
    case digit(value: Int)
    case floatPoint
    case clear(current: Bool)
    case changeSign
    case percent
    case division
    case multiply
    case addition
    case subtraction
    case equal
}
