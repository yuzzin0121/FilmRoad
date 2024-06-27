//
//  NavigationLazyView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/27/24.
//

import SwiftUI

struct NavigationLazyView<T: View>: View {
    let build: () -> T
    
    init(_  build: @autoclosure @escaping () -> T) {
        self.build = build
    }
    var body: some View {
        build()
    }
}

