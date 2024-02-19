//
//  MainCoordinator.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 16/02/2024.
//

import Foundation
import SwiftUI

struct MainCoordinator: View {
    @ObservedObject var coordinatorObject: MainCoordinatorObject
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.paletteBackground
                TransactionListView(viewModel: coordinatorObject.transactionListViewModel)
            }
            .navigation(item: $coordinatorObject.transactionDetailsViewModel) { viewModel in
                TransactionDetailsView(viewModel: viewModel)
            }
            .alert(item: $coordinatorObject.handleError, content: { item in
                Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
            })
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MainCoordinator(coordinatorObject: .init(dependencies: Dependencies()))
}
