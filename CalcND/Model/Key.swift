//
//  Key.swift
//  CalcND
//
//  Created by mst on 09.10.2020.
//  Copyright © 2020 mst. All rights reserved.
//

import UIKit

struct Key {
    let type: ActionType

    init(type: ActionType) {
        self.type = type
    }

    var text: String {
        switch type {
        case .zero:
            return "0"
        case .digit(let value):
            return String(value)
        case .floatPoint:
            return ","
        case .clear:
            return "C"
        case .percent:
            return "%"
        case .changeSign:
            return "+/-"
        case .division:
            return "÷"
        case .multiply:
            return "×"
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        case .equal:
            return "="
        }
    }

    var color: UIColor {
        switch type {
        case .zero, .digit, .floatPoint:
            return #colorLiteral(red: 0.1960214674, green: 0.1960555315, blue: 0.1960140169, alpha: 1)
        case .clear, .changeSign, .percent:
            return #colorLiteral(red: 0.6805036068, green: 0.680603385, blue: 0.6804817319, alpha: 1)
        default:
            return #colorLiteral(red: 0.9889778495, green: 0.5846265554, blue: 0, alpha: 1)
        }
    }

    var textColor: UIColor {
        switch type {
        case .clear, .changeSign, .percent:
            return .black
        default:
            return .white
        }
    }
}
