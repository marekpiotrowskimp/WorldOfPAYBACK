//
//  TransactionCellView.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import SwiftUI

struct TransactionCellView: View {
    @ObservedObject var viewModel: TransactionCellViewModel
    var body: some View {
        ZStack {
            Color.paletteGreen
            VStack(spacing: Metrics.spacingOne.value) {
                Text(viewModel.item.partnerDisplayName)
                    .withCellTitle()
                HStack(alignment: .top, spacing: Metrics.spacingOne.value) {
                    Text(viewModel.item.transactionDetail.description ?? .init())
                        .withCellDescription()
                        .padding([.leading, .bottom], Metrics.spacingTwo.value)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(viewModel.date.formatted())")
                            .withCellValues()
                        Text(viewModel.currency)
                            .withCellValues()
                    }
                    .padding([.trailing, .bottom], Metrics.spacingTwo.value)
                }
            }
        }
        .cornerRadius(Metrics.spacingTwo.value)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.paletteBackground.ignoresSafeArea()
        TransactionCellView(viewModel: .init(item: .mock, coordinator: MainCoordinatorObject(dependencies: .init())))
            .frame(height: 100)
            
    }.preferredColorScheme(.dark)
}


