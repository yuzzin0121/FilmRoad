//
//  MainTabView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0
    
    init() {
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().unselectedItemTintColor = .systemGray
    }
    var body: some View {
        
        TabView(selection: $selection){
            MovieListView()
                .customTabItem(selection == 0 ? TabItem.home.selectedImage : TabItem.home.image, TabItem.home.title)
                .tag(0)
            
            MyListView()
                .customTabItem(selection == 1 ? TabItem.myList.selectedImage : TabItem.myList.image, TabItem.myList.title)
                .tag(1)
            
            MyProfileView()
                .customTabItem(selection == 2 ? TabItem.profile.selectedImage : TabItem.profile.image, TabItem.profile.title)
                .tag(2)
        }
        .accentColor(Color.white)
    }
}

#Preview {
    MainTabView()
}
