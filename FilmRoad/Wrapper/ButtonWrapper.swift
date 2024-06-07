//
//  ButtonWrapper.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier {
    let action: () -> Void
    func body(content: Content) -> some View {
        Button(action: action,
               label: { content })
    }
}

extension View {
    func wrapToButton(action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action))
    }
}
