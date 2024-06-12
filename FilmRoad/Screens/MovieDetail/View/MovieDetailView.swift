//
//  MovieDetailView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack {
                posterImage(tv: viewModel.tv)
                VStack {
                    tvText(name: viewModel.tv?.name)
                    
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                Spacer()
            }
        }
        .task {
            viewModel.action(.viewOnAppear)
        }
    }
    
    func tvText(name: String?) -> some View {
        HStack {
            Text(name ?? "")
                .font(.title3).bold()
            
            Spacer()
        }
    }
    
    func descriptionText(_ description: String?) -> some View {
        HStack {
            Text(description ?? "")
                .font(.caption)
            Spacer()
        }
    }
    
    func posterImage(tv: TV?) -> some View {
        AsyncImage(url: URL(string: APIKey.basePosterURL.rawValue + (tv?.posterPath ?? ""))) { image in
            NavigationLink {
               
            } label: {
                image
                    .resizable()
                    .frame(height: 230)
                    .scaledToFit()
                    .overlay {
                        VStack(alignment: .center) {
                            Image(ImageString.playCircle)
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
            }
        } placeholder: {
            NavigationLink {
              
            } label: {
                Rectangle()
                    .fill(.white.opacity(0.1))
                    .frame(height: 230)
            }
        }
    }
}
