//
//  TransactionItem+Extensions.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import Foundation

extension TransactionItem {
    static var mock: TransactionItem {
        .init(
            partnerDisplayName: "DisplayName_\(Int.random(in: 0...100))",
            alias: .init(reference: "alias"),
            category: 1,
            transactionDetail: .init(
                description: "description",
                bookingDate: "2022-06-23T10:59:05+0200",
                value: .init(
                    amount: 222,
                    currency: "PBP"
                )
            )
        )
    }
}
