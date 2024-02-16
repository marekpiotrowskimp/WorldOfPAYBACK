//
//  NetworkMonitorService.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import Foundation
import Network
import Combine

protocol NetworkMonitorProtocol {
    var isConnectedPublisher: AnyPublisher<Bool, Never> { get }
}

class NetworkMonitorService: NetworkMonitorProtocol {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor", qos: .background)
    private var isConnected = CurrentValueSubject<Bool, Never>(true)
    
    var isConnectedPublisher: AnyPublisher<Bool, Never> {
        isConnected
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    init() {
        networkMonitor.pathUpdateHandler = { path in
            Task { @MainActor in
                self.isConnected.send(path.status == .satisfied || !path.availableInterfaces.isEmpty)
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
