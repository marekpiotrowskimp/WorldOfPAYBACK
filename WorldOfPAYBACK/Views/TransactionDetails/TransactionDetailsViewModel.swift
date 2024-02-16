//
//  TransactionDetailsViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import Foundation

class TransactionDetailsViewModel: ObservableObject {
    private unowned let coordinator: MainCoordinatorObject
    let item: TransactionItem
    
    init(item: TransactionItem, coordinator: MainCoordinatorObject) {
        self.item = item
        self.coordinator = coordinator
    }
}
