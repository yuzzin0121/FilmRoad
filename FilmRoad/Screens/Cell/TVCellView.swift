//
//  TVCellView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct TVCellView: View {
    var tv: TV
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: APIKey.basePosterURL.rawValue + tv.posterPath)) { data in
                switch data {
                case .empty:
                    ProgressView()
                        .frame(width: 200, height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200)
                        .clipShape(.rect(cornerRadius: 12))
                case .failure(let error):
                    Image(systemName: "star")
                        .background(.yellow)
                        .clipShape(Circle())
                @unknown default:
                    Image(systemName: "star")
                        .background(.yellow)
                        .clipShape(Circle())
                }
            }
                .scaledToFit()
                .frame(width: 150, height: 200)
        }
    }
}

#Preview {
    TVCellView(tv: 
                TV(id: 244643,
                  name: "El amor no tiene receta",
                  originalName: "El amor no tiene receta",
                  posterPath: "/fDRy8B1KdapuvBsgkCkEETY4MNr.jpg",
                  backdropPath: "/bIhmqQNXcyWRzH153d3jaCbLTy3.jpg")
    )
}
