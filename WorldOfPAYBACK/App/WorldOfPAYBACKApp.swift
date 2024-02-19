//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 16/02/2024.
//

import SwiftUI

@main
struct WorldOfPAYBACKApp: App {
    let dependencies = Dependencies()
    
    var body: some Scene {
        WindowGroup {
            MainCoordinator(coordinatorObject: .init(dependencies: dependencies))
        }
    }
}
