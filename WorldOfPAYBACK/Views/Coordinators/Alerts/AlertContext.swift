//
//  AlertContext.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 18/02/2024.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    var id: UUID { UUID() }
    let title: Text
    let message: Text?
    let dismissButton: Alert.Button?
}


enum AlertContext {
    static let fetchingData = AlertItem(
        title: Text("Communication Error"),
        message: Text("Upps... There is a problem during feching data."),
        dismissButton: .default(Text("Ok"))
    )
    
    static let internetConnection = AlertItem(
        title: Text("Internet connection"),
        message: Text("No Internet connection. Check your Wi-Fi."),
        dismissButton: .default(Text("Ok"))
    )
}
