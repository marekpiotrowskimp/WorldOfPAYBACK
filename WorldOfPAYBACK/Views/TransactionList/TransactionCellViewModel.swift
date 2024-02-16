//
//  TransactionCellViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import Foundation

class TransactionCellViewModel: ObservableObject {
    private unowned let coordinator: MainCoordinatorObject
    let item: TransactionItem
    
    var currency: String {
        let amount = item.transactionDetail.value.amount
        return amount.formatted(.currency(code: item.transactionDetail.value.currency))
    }
    
    var date: Date {
        let date = CalendarDateFormatter.dateTime.dataFormatter.date(from: item.transactionDetail.bookingDate)
        return date ?? .now
    }
    
    init(item: TransactionItem, coordinator: MainCoordinatorObject) {
        self.item = item
        self.coordinator = coordinator
    }
}

