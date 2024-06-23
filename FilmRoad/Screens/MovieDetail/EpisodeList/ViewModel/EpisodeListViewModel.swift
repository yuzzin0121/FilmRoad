//
//  EpisodeListViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/23/24.
//

import Foundation
import Combine

@MainActor
final class EpisodeListViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    
    init(seriesId: Int?, seasonNumber: Int) {
        transform()
        input.seasonInfo.send((seriesId, seasonNumber))
    }
    
    private func transform() {
        input.viewOnAppear
            .combineLatest(input.seasonInfo)
            .sink { [weak self] seasonInfo in
                guard let self else { return }
                let (_, seasonInfo) = seasonInfo
                Task {
                    await self.fetchEpisodeList(seriesId: seasonInfo.0, seasonNumber: seasonInfo.1)
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchEpisodeList(seriesId: Int?, seasonNumber: Int) async {
        guard let seriesId else { return }
        do {
            let episodeListResponseModel = try await TMDBNetworkManager.shared.requestToTMDB(model: EpisodeListResponseModel.self, router: TMDBRouter.tvSeasonsDetails(seriesId: seriesId, seasonNumber: seasonNumber))
            output.episodeList = episodeListResponseModel.episodes
        } catch {
            return
        }
    }
}

extension EpisodeListViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
        var seasonInfo = PassthroughSubject<(Int?, Int), Never>()
    }
    struct Output {
        var episodeList: [Episode] = []
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
