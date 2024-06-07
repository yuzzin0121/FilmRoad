//
//  NavigationBarWrapper.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

private struct NavigationBarWrapper<L: View, T: View>: ViewModifier {
    let leading: L
    let trailing: T
    
    init(leading: () -> L, trailing: () -> T) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    leading
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailing
                }
            }
    }
}

extension View {
    func navigationBar(@ViewBuilder leading: () -> some View, @ViewBuilder trailing: () -> some View) -> some View {
        modifier(NavigationBarWrapper(leading: leading, trailing: trailing))
    }
}
