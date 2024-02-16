//
//  NavigationModifier.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import SwiftUI

struct NavigationModifier: ViewModifier {
    let action: () -> Void
    func body(content: Content) -> some View {
        Button(action: action, label: {
            content
        })
        .buttonStyle(NavigationButtonStyle())
    }
}

struct NavigationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if configuration.isPressed {
            configuration.label
                .scaleEffect(CGSize(width: 1.07, height: 1.07), anchor: .center)
        } else {
            configuration.label
        }
    }
}

extension View {
    func onNavigation(_ action: @escaping () -> Void) -> some View {
        self.modifier(NavigationModifier(action: action))
    }
}


