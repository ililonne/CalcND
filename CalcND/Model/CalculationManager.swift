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

    private enum Mode {
        case integer
        case float
    }

    private let clearKey = Key(type: .clear(current: false))
    let keys: [Key]

    weak var delegate: CalculationManagerDelegate? {
        didSet {
            delegate?.showResult("0")
        }
    }

    private var currentNumber: Double = 0
    private var savedNumber: Double = 0
    private var currentAction = ActionType.equal
    private var currentMode = Mode.integer
    private var currentNumberFractionalPartLength = 0

    private var needResetCurrent = false

    init() {
        keys = [
            clearKey,
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
    }

    func selectKey(index: Int) {
        switch keys[index].type {
        case .zero:
            selectDigit(value: 0)
        case .digit(let value):
            selectDigit(value: value)
        case .floatPoint:
            selectFloatPoint()
        case .clear(let current):
            selectClear(current: current)
        case .changeSign:
            selectChangeSign()
        case .percent:
            selectPercent()
        case .division:
            selectAction(.division)
        case .multiply:
            selectAction(.multiply)
        case .addition:
            selectAction(.addition)
        case .subtraction:
            selectAction(.subtraction)
        case .equal:
            selectEqual()
        }
    }

    private func selectDigit(value: Int) {
        if needResetCurrent {
            currentNumber = 0
            currentNumberFractionalPartLength = 0
        }
        needResetCurrent = false
        switch currentMode {
        case .integer:
            currentNumber *= 10
            if currentNumber >= 0 {
                currentNumber += Double(value)
            } else {
                currentNumber -= Double(value)
            }
            delegate?.showResult(String(format: "%0.0f", currentNumber))
        case .float:
            currentNumberFractionalPartLength += 1
            let fractionalPart = Double(value) * pow(Double(10), Double(-currentNumberFractionalPartLength))
            if currentNumber >= 0 {
                currentNumber += fractionalPart
            } else {
                currentNumber -= fractionalPart
            }
            delegate?.showResult(currentNumber.removeZeros())
        }
        clearKey.type = .clear(current: true)
    }

    private func selectFloatPoint() {
        if !needResetCurrent, case .integer = currentMode {
            currentMode = .float
            delegate?.showResult(String(format: "%1.0f", currentNumber) + ",")
        }
    }

    private func selectClear(current: Bool) {
        currentNumber = 0
        currentNumberFractionalPartLength = 0
        if !current {
            savedNumber = 0
            currentAction = .equal
        }
        delegate?.showResult(String(format: "%1.0f", currentNumber))
        clearKey.type = .clear(current: false)
        currentMode = .integer
        needResetCurrent = false
    }
    
    private func selectChangeSign() {
        currentNumber *= -1
        delegate?.showResult(currentNumber.removeZeros())
        needResetCurrent = false
    }

    private func selectPercent() {
        currentNumber /= 100
        delegate?.showResult(currentNumber.removeZeros())
        needResetCurrent = true
    }

    private func selectAction(_ action: ActionType) {
        checkOperation()
        currentNumber = 0
        currentNumberFractionalPartLength = 0
        currentAction = action
        currentMode = .integer
    }

    private func selectEqual() {
        checkOperation()
        currentAction = .equal
        currentMode = .integer
        currentNumber = savedNumber
        needResetCurrent = true
    }

    private func checkOperation() {
        switch currentAction {
        case .division:
            savedNumber = savedNumber/currentNumber
        case .multiply:
            savedNumber = savedNumber*currentNumber
        case .addition:
            savedNumber = savedNumber+currentNumber
        case .subtraction:
            savedNumber = savedNumber-currentNumber
        default:
            savedNumber = currentNumber
        }
        delegate?.showResult(savedNumber.removeZeros().replacingOccurrences(of: ".", with: ","))
    }
}
