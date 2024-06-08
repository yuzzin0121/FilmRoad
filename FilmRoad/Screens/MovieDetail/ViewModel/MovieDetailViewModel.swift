//
//  MovieDetailViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import Foundation
import Combine

final class MovieDetailViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    init() {
        transform()
    }
    
    private func transform() {
        
    }
}

extension MovieDetailViewModel {
    struct Input {
        var tv: TV?
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    struct Output {
    }
    
    enum Action {
        case viewOnAppear
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewOnAppear:
            input.viewOnAppear.send(())
        }
    }
}
