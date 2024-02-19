//
//  Dependencies.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 18/02/2024.
//

import Foundation

class Dependencies {
    let transactionService: NetworkServiceProtocol =  Bundle.main.isMockService ? MockNetworkService() : NetworkService()
    let networkMonitor: NetworkMonitorProtocol = NetworkMonitorService()
}
