//
//  NavigationWrapper.swift
//  FilmRoad
//
//  Created by 조유진 on 6/27/24.
//

import SwiftUI

struct NavigationWrapper<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
        }
    }
}
