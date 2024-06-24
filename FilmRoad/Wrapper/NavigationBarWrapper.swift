//
//  NavigationBarWrapper.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

private struct NavigationBarWrapper<Title: View, L: View, T: View>: ViewModifier {
    let title: Title
    let leading: L
    let trailing: T
    
    init(title: () -> Title, leading: () -> L, trailing: () -> T) {
        self.title = title()
        self.leading = leading()
        self.trailing = trailing()
    }
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    title
                }
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
    func navigationBar(@ViewBuilder title: () -> some View, @ViewBuilder leading: () -> some View, @ViewBuilder trailing: () -> some View) -> some View {
        modifier(NavigationBarWrapper(title: title, leading: leading, trailing: trailing))
    }
}
