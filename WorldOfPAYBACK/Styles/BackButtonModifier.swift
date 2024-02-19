//
//  BackButtonModifier.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 18/02/2024.
//

import Foundation
import SwiftUI

struct BackButtonModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.primary)
                    }
                    
                }
            }
    }
}

extension View {
    func withBackButton() -> some View {
        modifier(BackButtonModifier())
    }
}
