//
//  TVVideoView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/24/24.
//

import SwiftUI

struct TVVideoView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: TVVideoViewModel
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            TVWebView(urlString: viewModel.output.videoURL)
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
        .task {
            viewModel.action(.viewOnAppear)
        }
    }
}
