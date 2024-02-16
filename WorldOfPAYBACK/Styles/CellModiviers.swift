//
//  CellModiviers.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import Foundation
import SwiftUI

struct TitleCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(Color.paletteGray)
    }
}

struct DescriptionCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundStyle(Color.paletteGray)
    }
}

struct ValuesCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(Color.paletteGray)
    }
}

extension View {
    func withCellTitle() -> some View {
        modifier(TitleCellModifier())
    }
    func withCellDescription() -> some View {
        modifier(DescriptionCellModifier())
    }
    func withCellValues() -> some View {
        modifier(ValuesCellModifier())
    }
}
