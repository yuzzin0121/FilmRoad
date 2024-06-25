//
//  SubProfileInfoWrapper.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import SwiftUI

private struct SubTitleFontWrapper: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .foregroundStyle(color)
    }
}

extension View {
    func subTitleFont(_ color: Color) -> some View {
        modifier(SubTitleFontWrapper(color: color))
    }
}
