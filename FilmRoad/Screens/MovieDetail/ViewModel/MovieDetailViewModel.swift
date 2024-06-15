//
//  MovieDetailViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import Foundation
import Combine

@MainActor
final class MovieDetailViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    @Published var tv: TV?
    
    
    init(tv: TV?) {
        self.tv = tv
        transform()
    }
    
    private func transform() {
        input.viewOnAppear.sink { [weak self] _ in
            guard let self, let tv = self.tv else { return }
            Task {
                let tvInfo = await self.fetchTVInfo()
                print(tvInfo)
                self.output.tvInfoModel = tvInfo
            }
        }
        .store(in: &cancellables)
    }
    
    private func fetchTVInfo() async -> TVInfoResponseModel? {
        guard let tv else { return nil }
        do {
            let tvInfoModel = try await TMDBNetworkManager.shared.requestToTMDB(model: TVInfoResponseModel.self, router: TMDBRouter.tvInfo(id: tv.id))
            return tvInfoModel
        } catch {
            return nil
        }
    }
}

extension MovieDetailViewModel {
    struct Input {
        var tv: TV?
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    struct Output {
        var tvInfoModel: TVInfoResponseModel?
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
