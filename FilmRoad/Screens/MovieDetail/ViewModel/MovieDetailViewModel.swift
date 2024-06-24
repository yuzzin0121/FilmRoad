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
    
    init(tv: TV?) {
        transform()
        input.tv.send(tv)
    }
    
    private func transform() {
        input.tv
            .sink { [weak self] tv in
                guard let self else { return }
                output.tv = tv
            }
            .store(in: &cancellables)
        
        input.viewOnAppear
            .combineLatest(input.tv)
            .sink { [weak self] (_, tv) in
            guard let self else { return }
            Task {
                await self.fetchTVInfo(tv: tv)
            }
        }
        .store(in: &cancellables)
        
        input.setBookmark
            .combineLatest(input.tv)
            .sink { [weak self] (_, tv) in
                guard let self, var tv else { return }
                tv.isBookmarked.toggle()
                input.tv.send(tv)
            }
            .store(in: &cancellables)
        
        input.selectedInfoIndex.sink { [weak self] selectedIndex in
            guard let self else { return }
            output.currentInfoIndex = selectedIndex
            switch selectedIndex {
            case TVInfoItem.season.rawValue:
                break
            case TVInfoItem.castInfo.rawValue:
                Task {
                    await self.fetchTVCastInfo()
                }
            case TVInfoItem.similarContents.rawValue:
                Task {
                    await self.fetchSimilarContents()
                }
            default:
                break
            }
        }
        .store(in: &cancellables)
    }
    
    // TV 상세정보 조회
    private func fetchTVInfo(tv: TV?) async {
        guard let tv else { return }
        do {
            let tvInfoModel = try await TMDBNetworkManager.shared.requestToTMDB(model: TVInfoResponseModel.self, router: TMDBRouter.tvInfo(id: tv.id))
            output.tvInfoModel = tvInfoModel
            output.seasonList = tvInfoModel.seasons
        } catch {
            return
        }
    }
    
    // 캐스트 정보 조회
    private func fetchTVCastInfo() async {
        guard let tv = output.tvInfoModel else { return }
        do {
            let tvCastInfoModel = try await TMDBNetworkManager.shared.requestToTMDB(model: TVCastInfoModel.self, router: TMDBRouter.dramaCaseInfo(id: tv.id))
            output.castList = tvCastInfoModel.cast
        } catch {
            return
        }
    }
    
    // 비슷한 콘텐츠 조회
    private func fetchSimilarContents() async {
        guard let tv = output.tvInfoModel else { return }
        do {
            let similarTVModel = try await TMDBNetworkManager.shared.requestToTMDB(model: SimilarTVModel.self, router: TMDBRouter.similarTVRecommendation(id: tv.id))
            output.similarTVList = similarTVModel.results
        } catch {
            return
        }
    }
}

extension MovieDetailViewModel {
    struct Input {
        var tv = PassthroughSubject<TV?, Never>()
        var viewOnAppear = PassthroughSubject<Void, Never>()
        var selectedInfoIndex = PassthroughSubject<Int, Never>()
        var setBookmark = PassthroughSubject<Void, Never>()
    }
    struct Output {
        var tv: TV?
        var tvInfoModel: TVInfoResponseModel?
        var currentInfoIndex: Int = 0
        var seasonList: [Season] = []
        var castList: [Cast] = []
        var similarTVList: [TV] = []
    }
    
    enum Action {
        case viewOnAppear
        case selectInfoIndex(index: Int)
        case setBookmark
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewOnAppear:
            input.viewOnAppear.send(())
        case .selectInfoIndex(let index):
            input.selectedInfoIndex.send(index)
        case .setBookmark:
            input.setBookmark.send(())
        }
    }
}
