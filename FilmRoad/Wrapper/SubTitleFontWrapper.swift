//
//  SubProfileInfoWrapper.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import SwiftUI

private struct SubTitleFontWrapper: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .foregroundStyle(.gray)
    }
}

extension View {
    func subTitleFont() -> some View {
        modifier(SubTitleFontWrapper())
    }
}
