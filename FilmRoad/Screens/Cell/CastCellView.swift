//
//  CastCellView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/21/24.
//

import SwiftUI

struct CastCellView: View {
    var cast: Cast

    var body: some View {
        VStack {
            Text(cast.knownForDepartment)
                .font(.system(size: 13))
                .foregroundStyle(.white)
            CastImageView(profilPath: cast.profilPath)
            Text(cast.name)
                .font(.system(size: 13))
                .foregroundStyle(.white)
            Spacer()
        }
        .frame(height: 130)
    }
}

struct CastImageView: View {
    var profilPathURL: URL?
    
    init(profilPath: String?) {
        guard let profilPath else { return }
        profilPathURL = URL(string: APIKey.basePosterURL.rawValue + profilPath) ?? nil
    }
    
    var body: some View {
        AsyncImage(url: profilPathURL) { image in
            image
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
        } placeholder: {
            Circle()
                .fill(.white.opacity(0.2))
                .frame(width: 60, height: 60)
            
        }
    }
}

#Preview {
    CastCellView(cast: Cast(knownForDepartment: "Acting", name: "Jeremy Jordan", profilPath: "/idYjWWH7LbXFxQlqJes0DWbztpf.jpg", roles: [Role(character: "Additional Voices (voice)")]))
}
