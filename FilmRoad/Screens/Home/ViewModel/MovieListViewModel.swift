//
//  MovieListViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import Foundation
import Combine

@MainActor
final class MovieListViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    init() {
        transform()
    }
    
    private func transform() {
        input.viewOnAppear
            .sink { [weak self] in
                guard let self else { return }
                Task {
                    let topRated = await self.fetchTV(router: TMDBRouter.topRated)
                    let trend = await self.fetchTV(router: TMDBRouter.trend(page: 1))
                    let popular = await self.fetchTV(router: TMDBRouter.popular(page: 1))
                    self.output.tvTotalList = []
                    self.getRandomTV(tvList: topRated)
                    self.appendTVList(tvList: topRated)
                    self.appendTVList(tvList: trend)
                    self.appendTVList(tvList: popular)
                }
            }
            .store(in: &cancellables)
    }
    
    private func getRandomTV(tvList: [TV]) {
        guard let randomTV = tvList.randomElement() else { return }
        output.randomTV = randomTV
    }
    
    private func appendTVList(tvList: [TV]) {
        self.output.tvTotalList.append(tvList)
    }
    
    private func fetchTV(router: TMDBRouter) async -> [TV] {
        do {
            let tvResponseModel = try await TMDBNetworkManager.shared.requestToTMDB(model: TVResponseModel.self, router: router)
            return tvResponseModel.results
        } catch {
            return []
        }
    }
}

extension MovieListViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    struct Output {
        var tvTotalList: [[TV]] = []
        var randomTV: TV?
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
