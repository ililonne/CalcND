//
//  Double+Ext.swift
//  CalcND
//
//  Created by mst on 09.10.2020.
//  Copyright © 2020 mst. All rights reserved.
//
import Foundation

fileprivate let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 8
    return formatter
}()

extension Double {
    func removeZeros() -> String {
        return String(numberFormatter.string(from: NSNumber(value: self)) ?? "").replacingOccurrences(of: ".", with: ",")
    }
}
