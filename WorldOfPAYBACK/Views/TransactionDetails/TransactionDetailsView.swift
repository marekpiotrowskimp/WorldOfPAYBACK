//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import SwiftUI

struct TransactionDetailsView: View {

    @ObservedObject var viewModel: TransactionDetailsViewModel

    var body: some View {
        ZStack {
            Color.paletteBackground
                .ignoresSafeArea()
            VStack(spacing: Metrics.spacingFour.value) {
                Text(viewModel.item.partnerDisplayName)
                    .font(.title)
                    .foregroundStyle(.paletteGreen)
                Text(viewModel.item.transactionDetail.description ?? String(localized: "empty"))
                    .font(.title2)
                    .foregroundStyle(.paletteGreen)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay {
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .stroke(.paletteGreen, style: .init(lineWidth: 1))
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(viewModel.item.partnerDisplayName)
        .withBackButton()
    }
}

// MARK: - Preview

#Preview {
    TransactionDetailsView(
        viewModel: .init(
            item: .mock,
            coordinator: MainCoordinatorObject(dependencies: .init())
        )
    )
}
