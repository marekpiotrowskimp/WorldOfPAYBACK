//
//  CustomerErrors.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 18/02/2024.
//

import Foundation

enum CustomerErrors: Error {
    case serverError
    case internetConnection
    
    
    func showUrlAlert() -> AlertItem {
        switch self {
        case .serverError:
            return AlertContext.fetchingData
        case .internetConnection:
            return AlertContext.internetConnection
        }
    }
}
