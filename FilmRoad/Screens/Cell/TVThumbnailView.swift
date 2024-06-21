//
//  TVThumbnailView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct TVThumbnailView: View {
    var posterWitdh = (UIScreen.main.bounds.width - (12 * 3)) / 3
    var tv: TV
    
    var body: some View {
        AsyncImage(url: URL(string: APIKey.basePosterURL.rawValue + tv.posterPath)) { data in
            switch data {
            case .empty:
                ProgressView()
                    .frame(width: posterWitdh, height: 180)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: posterWitdh, height: 180)
                    .clipShape(.rect(cornerRadius: 12))
            case .failure(_):
                Image(ImageString.video)
                    .frame(width: posterWitdh, height: 180)
            @unknown default:
                Image(ImageString.video)
                    .frame(width: posterWitdh, height: 180)
            }
        }
        .scaledToFit()
        .frame(width: posterWitdh, height: 180)
    }
}

#Preview {
    TVThumbnailView(tv: 
                TV(id: 244643,
                  name: "El amor no tiene receta",
                  originalName: "El amor no tiene receta",
                  posterPath: "/fDRy8B1KdapuvBsgkCkEETY4MNr.jpg",
                  backdropPath: "/bIhmqQNXcyWRzH153d3jaCbLTy3.jpg")
    )
}
