//
//  SearchFilmView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct SearchFilmView: View {
    @Environment(\.dismiss) var dismiss
    @State private var query: String = ""
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            Text("SearchFilmView")
        }
        .searchable(text: $query)
        .navigationBarBackButtonHidden(true)    // default 버튼 지우기
        .navigationBar {
            Button{
                dismiss()
            }label: {
                Image(ImageString.arrowLeft)
            }
        } trailing: { }
        .foregroundStyle(.white)
    }
}

#Preview {
    SearchFilmView()
}
