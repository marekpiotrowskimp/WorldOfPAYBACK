//
//  TransactionListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 16/02/2024.
//

import Foundation
import Combine

class TransactionListViewModel: ObservableObject {
    @Published var transactions: [TransactionItem] = []
    @Published var filteredTransactions: [TransactionItem] = []
    @Published var categories: Set<Int>
    @Published var sumOfAmount: SumAmount
    @Published var filter: Int
    @Published var waitingIndicator: Bool = false
    private unowned let coordinator: MainCoordinatorObject
    private var cancellable = Set<AnyCancellable>()
    private let transactionService: NetworkServiceProtocol
    
    init(transactions: [TransactionItem] = [], coordinator: MainCoordinatorObject, transactionService: NetworkServiceProtocol) {
        self.transactions = transactions
        self.coordinator = coordinator
        self.categories = .init()
        self.filter = .zero
        self.sumOfAmount = SumAmount()
        self.transactionService = transactionService
        bindings()
        transactionBindings()
    }
    
    private func bindings() {
        $transactions
            .receive(on: RunLoop.main)
            .sink { [weak self] trans in
                guard let self = self else { return }
                self.categories = Set(trans.map { $0.category })
                self.categories.insert(.zero)
            }
            .store(in: &cancellable)
        
        Publishers.CombineLatest($filter, $transactions)
            .map { filterValue, transactionsList in
                transactionsList.filter { $0.category == filterValue || filterValue == .zero }.sorted { item1, item2 in
                    item1.transactionDetail.bookingDate > item2.transactionDetail.bookingDate
                }
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] trans in
                self?.filteredTransactions = trans
            }
            .store(in: &cancellable)
            
        $filteredTransactions
            .receive(on: RunLoop.main)
            .sink { [weak self] trans in
                self?.sumOfAmount = trans.reduce(SumAmount()) { partialResult, item in
                    partialResult.add(value: item.transactionDetail.value)
                    return partialResult
                }
            }
            .store(in: &cancellable)
    }
    
    private func transactionBindings() {
        transactionService.dataPublisher(request: TransactionRequest())
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                self?.handleTransactions(result)
            }
            .store(in: &cancellable)
        
        transactionService.isBussyPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] isBusy in
                self?.waitingIndicator = isBusy
            }
            .store(in: &cancellable)
    }
  
    private func handleTransactions(_ result: Result<Transactions, ServiceError>) {
        switch result {
        case .success(let transactions):
            self.transactions = transactions.items
        case .failure(let error):
            switch error {
            case .badResponse, .badUrl, .connection, .deserializer:
                coordinator.showError(.serverError)
                self.transactions = []
            }
        }
    }
}

extension TransactionListViewModel {
    
    func getFilterName(id: Int) -> String {
        switch id {
        case .zero: return String(localized: "None")
        default: return "\(String(localized: "Category")) \(id)"
        }
    }
    
    func cellViewModel(_ item: TransactionItem) -> TransactionCellViewModel {
        .init(item: item, coordinator: coordinator)
    }
    
    func openDetails(item: TransactionItem) {
        coordinator.openDetails(item)
    }
    
    func refresh() {
        transactionService.getTransations()
    }
}
