//
//  Bundle+Extensions.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import Foundation

extension Bundle {
    var apiBaseURL: String {
        return object(forInfoDictionaryKey: "BASE_URL") as? String ?? "empty"
    }
    var isMockService: Bool {
        return (object(forInfoDictionaryKey: "MOCK_SERVICE") as? String)?.lowercased() == "yes"
    }
}
