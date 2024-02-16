//
//  TransactionSumCellView.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 18/02/2024.
//

import SwiftUI

struct TransactionSumCellView: View {
    @Binding var sumOfAmount: SumAmount
    var body: some View {
        HStack(alignment: .top) {
            Spacer()
            VStack {
                if sumOfAmount.sumByCurrency.isEmpty {
                    emptySumView()
                } else {
                    listOfSumView()
                }
            }
            .padding(.vertical, Metrics.spacingTwo.value)
            .padding(.horizontal, Metrics.spacingFour.value)
            .background(.paletteOrange)
            .cornerRadius(Metrics.spacingTwo.value)
        }
    }
    
    @ViewBuilder func listOfSumView() -> some View {
        ForEach(sumOfAmount.sumByCurrency.sorted(by: >), id: \.key) { sum in
            Text(sum.value.formatted(.currency(code: sum.key)))
                .withCellValues()
        }
    }
    
    @ViewBuilder func emptySumView() -> some View {
        Text("-----")
            .withCellValues()
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.paletteBackground.ignoresSafeArea()
        TransactionSumCellView(sumOfAmount: Binding(get: { SumAmount() }, set: { _ in }))
    }.preferredColorScheme(.dark)
}

