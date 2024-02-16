//
//  MainCoordinatorObject.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 18/02/2024.
//

import Foundation
import Combine

class MainCoordinatorObject: ObservableObject {
    @Published var transactionListViewModel: TransactionListViewModel!
    @Published var transactionDetailsViewModel: TransactionDetailsViewModel?
    @Published var handleError: AlertItem?
    private let dependencies: Dependencies
    private var cancellable = Set<AnyCancellable>()
    
    init(dependencies: Dependencies, transactionListViewModel: TransactionListViewModel? = nil) {
        self.dependencies = dependencies
        self.transactionListViewModel = transactionListViewModel ?? .init(coordinator: self, transactionService: dependencies.transactionService)
        bindings(networkMonitor: dependencies.networkMonitor)
    }
    
    func openDetails(_ item: TransactionItem) {
        transactionDetailsViewModel = .init(item: item, coordinator: self)
    }
    
    func showError(_ item: CustomerErrors) {
        handleError = item.showUrlAlert()
    }
    
    private func bindings(networkMonitor: NetworkMonitorProtocol) {
        networkMonitor.isConnectedPublisher
            .sink { [weak self] isConnected in
                guard !isConnected else { return }
                self?.showError(.internetConnection)
            }
            .store(in: &cancellable)
    }
}
