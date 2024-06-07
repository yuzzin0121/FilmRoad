//
//  TabItemModifier.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct CustomTabItemWrapper: ViewModifier {
    let imageString: String
    let title: String
    
    func body(content: Content) -> some View {
        content
            .tabItem {
                Image(imageString)
                Text(title)
            }
    }
}


extension View {
    func customTabItem(_ imageString: String, _ title: String) -> some View {
        modifier(CustomTabItemWrapper(imageString: imageString, title: title))
    }
}
