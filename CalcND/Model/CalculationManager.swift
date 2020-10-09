//
//  CalculationManager.swift
//  CalcND
//
//  Created by mst on 09.10.2020.
//  Copyright © 2020 mst. All rights reserved.
//

import Foundation

protocol CalculationManagerDelegate: class {
    func showResult(_ result: String)
}

class CalculationManager {

    let keys: [Key] = [
        Key(type: .clear),
        Key(type: .changeSign),
        Key(type: .percent),
        Key(type: .division),
        Key(type: .digit(value: 7)),
        Key(type: .digit(value: 8)),
        Key(type: .digit(value: 9)),
        Key(type: .multiply),
        Key(type: .digit(value: 4)),
        Key(type: .digit(value: 5)),
        Key(type: .digit(value: 6)),
        Key(type: .subtraction),
        Key(type: .digit(value: 1)),
        Key(type: .digit(value: 2)),
        Key(type: .digit(value: 3)),
        Key(type: .addition),
        Key(type: .zero),
        Key(type: .floatPoint),
        Key(type: .equal),
    ]

    weak var delegate: CalculationManagerDelegate? {
        didSet {
            delegate?.showResult("0")
        }
    }

    private var currentNumber: Double = 0
    private var savedNumber: Double = 0
    private var currentAction = ActionType.equal

    func selectKey(index: Int) {
        let selectedKey = keys[index]
        var text = ""
        switch selectedKey.type {
        case .zero:
            currentNumber *= 10
            text = String(format: "%1.0f", currentNumber)
        case .digit(let value):
            currentNumber *= 10
            currentNumber += Double(value)
            text = String(format: "%1.0f", currentNumber)
        case .floatPoint:
            text = String(format: "%1.0f", currentNumber)
        case .clear:
            break
        case .changeSign:
            currentNumber *= -1
            text = String(format: "%1.0f", currentNumber)
        case .percent:
            break
        case .division:
            savedNumber = currentNumber
            text = String(format: "%1.0f", currentNumber)
            currentNumber = 0
            currentAction = .division
        case .multiply:
            savedNumber = currentNumber
            text = String(format: "%1.0f", currentNumber)
            currentNumber = 0
            currentAction = .multiply
        case .addition:
            savedNumber = currentNumber
            text = String(format: "%1.0f", currentNumber)
            currentNumber = 0
            currentAction = .addition
        case .subtraction:
            savedNumber = currentNumber
            text = String(format: "%1.0f", currentNumber)
            currentNumber = 0
            currentAction = .subtraction
        case .equal:
            switch currentAction {
            case .division:
                currentNumber = savedNumber/currentNumber
            case .multiply:
                currentNumber = savedNumber*currentNumber
            case .addition:
                currentNumber = savedNumber+currentNumber
            case .subtraction:
                currentNumber = savedNumber-currentNumber
            default: break
            }
            text = String(format: "%1.0f", currentNumber)
            currentAction = .equal
        }
        delegate?.showResult(text)
    }
}
