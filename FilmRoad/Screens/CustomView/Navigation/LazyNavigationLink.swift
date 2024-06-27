//
//  LazyNavigationLink.swift
//  FilmRoad
//
//  Created by 조유진 on 6/27/24.
//

import SwiftUI

struct LazyNavigationLink<Destination, Label>: View where Destination: View, Label: View {
    private let destination: Destination
    private let label: Label
    
    public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }
    
    @MainActor var body: some View {
        NavigationLink {
            NavigationLazyView(destination)
        } label: {
            label
        }
    }
}
