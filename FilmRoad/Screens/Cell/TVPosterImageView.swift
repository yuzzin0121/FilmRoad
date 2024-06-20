//
//  TVPosterImageView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/17/24.
//

import SwiftUI

struct TVPosterImageView: View {
    var posterURLString: String? {
        didSet {
            guard let posterURLString else { return }
            posterURL = URL(string: posterURLString)
        }
    }
    
    var posterURL: URL?
     
    init(posterURLString: String? = nil) {
        self.posterURLString = posterURLString
    }
    
    var body: some View {
        AsyncImage(url: posterURL) { image in
            image
                .resizable()
                .frame(width: 140, height: 80)
        } placeholder: {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white.opacity(0.2))
                .frame(width: 140, height: 80)
            
        }
    }
}
