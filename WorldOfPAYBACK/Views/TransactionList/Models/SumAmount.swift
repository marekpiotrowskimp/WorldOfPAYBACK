//
//  SumAmount.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 18/02/2024.
//

import Foundation

class SumAmount {
    var sumByCurrency: [String: Double] = [:]
    
    func add(value: TransactionValue) {
        let currentValue: Double = sumByCurrency[value.currency] ?? .zero
        sumByCurrency[value.currency] = currentValue + value.amount
    }
}
