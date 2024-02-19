//
//  TransactionListView.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 16/02/2024.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: TransactionListViewModel
    
    var body: some View {
        VStack {
            filterView()
            listView()
        }
        .padding(.top, Metrics.spacingTen.value)
    }
    
    @ViewBuilder func listView() -> some View {
        if viewModel.filteredTransactions.isEmpty {
            emptyListView()
        } else {
            contentListView()
        }
    }
    
    @ViewBuilder func emptyListView() -> some View {
        Button(action: {
            viewModel.refresh()
        }, label: {
            VStack(spacing: Metrics.spacingEight.value) {
                Spacer()
                if viewModel.waitingIndicator {
                    Label("No content", systemImage: "list.bullet.rectangle.portrait")
                        .foregroundColor(.paletteOrange)
                } else {
                    Label("Tap to refresh", systemImage: "arrow.triangle.2.circlepath")
                        .foregroundColor(.paletteOrange)
                }
                Spacer()
            }
        })
    }
    
    @ViewBuilder func contentListView() -> some View {
        ScrollView {
            Spacer().frame(height: Metrics.spacingTwo.value)
            ForEach(viewModel.filteredTransactions) { item in
                TransactionCellView(viewModel: viewModel.cellViewModel(item))
                    .onNavigation {
                        viewModel.openDetails(item: item)
                    }
            }
            .padding(.horizontal, Metrics.spacingFour.value)
            TransactionSumCellView(sumOfAmount: $viewModel.sumOfAmount)
                .padding(.horizontal, Metrics.spacingFour.value)
            Spacer().frame(height: Metrics.spacingTen.value)
        }
        .clipped()
        .refreshable {
            viewModel.refresh()
        }
    }
    
    @ViewBuilder func waitingIndicatorView() -> some View {
        if viewModel.waitingIndicator {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .paletteOrange))
        }
    }
    
    @ViewBuilder func filterView() -> some View {
        HStack(spacing: Metrics.spacingTwo.value) {
            waitingIndicatorView()
            Spacer()
            Menu {
                Picker("empty", selection: Binding(get: { viewModel.filter }, set: { viewModel.filter = $0 })) {
                    ForEach(Array(viewModel.categories).sorted(), id: \.self) { element in
                        Text(viewModel.getFilterName(id: element))
                    }
                }
                .pickerStyle(DefaultPickerStyle())
            } label: {
                Button(action: {}) {
                    HStack {
                        Text("Filtered by")
                            .foregroundStyle(.paletteWhite)
                        Text(viewModel.getFilterName(id: viewModel.filter))
                            .foregroundStyle(.paletteOrange)
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.paletteWhite)
                    }
                }
            }
        }
        .padding(.vertical, Metrics.spacingTwo.value)
        .padding(.horizontal, Metrics.spacingFour.value)
        .background(.paletteDarkGray)
        .cornerRadius(Metrics.spacingTwo.value)
        .padding([.horizontal, .top], Metrics.spacingFour.value)
        .padding(.bottom, Metrics.spacingOne.value)
    }
}

// MARK: - Preview

#Preview {
    TransactionListView(viewModel: .init(transactions: [], coordinator: .init(dependencies: .init()), transactionService: MockNetworkService()))
        .preferredColorScheme(.dark)
}
