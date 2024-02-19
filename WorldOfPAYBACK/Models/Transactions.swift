//
//  Transactions.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 16/02/2024.
//

import Foundation

struct Transactions: Codable {
    let items: [TransactionItem]
}

// MARK: - TransactionItem
struct TransactionItem: Hashable, Codable, Identifiable {
    var id: String {
        alias.reference
    }
    
    let partnerDisplayName: String
    let alias: TransactionAlias
    let category: Int
    let transactionDetail: TransactionDetail
}

// MARK: - TransactionAlias
struct TransactionAlias: Hashable, Codable {
    let reference: String
}

// MARK: - TransactionDetail
struct TransactionDetail: Hashable, Codable {
    let description: String?
    let bookingDate: String
    let value: TransactionValue
}

// MARK: - TransactionValue
struct TransactionValue: Hashable, Codable {
    let amount: Double
    let currency: String
}

