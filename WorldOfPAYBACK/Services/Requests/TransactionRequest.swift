//
//  TransactionRequest.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 18/02/2024.
//

import Foundation

protocol BackendRequest {
    func getUrl() -> URL?
}

struct TransactionRequest: BackendRequest {
    let component = "transations"
    let baseUrlPath = Bundle.main.apiBaseURL
    func getUrl() -> URL? {
        URL(string: "\(baseUrlPath)\(component)")
    }
}
