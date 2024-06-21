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
                self.output.tvInfoModel = tvInfo
                guard let seasonList = tvInfo?.seasons else { return }
                self.output.seasonList = seasonList
            }
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
    private func fetchTVInfo() async -> TVInfoResponseModel? {
        guard let tv else { return nil }
        do {
            let tvInfoModel = try await TMDBNetworkManager.shared.requestToTMDB(model: TVInfoResponseModel.self, router: TMDBRouter.tvInfo(id: tv.id))
            return tvInfoModel
        } catch {
            return nil
        }
    }
    
    // 캐스트 정보 조회
    private func fetchTVCastInfo() async {
        guard let tv = output.tvInfoModel else { return }
        do {
            let tvCastInfoModel = try await TMDBNetworkManager.shared.requestToTMDB(model: TVCastInfoModel.self, router: TMDBRouter.dramaCaseInfo(id: tv.id))
            output.castList = tvCastInfoModel.cast
            print(output.castList)
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
        var tv: TV?
        var viewOnAppear = PassthroughSubject<Void, Never>()
        var selectedInfoIndex = PassthroughSubject<Int, Never>()
    }
    struct Output {
        var tvInfoModel: TVInfoResponseModel?
        var currentInfoIndex: Int = 0
        var seasonList: [Season] = []
        var castList: [Cast] = []
        var similarTVList: [TV] = []
    }
    
    enum Action {
        case viewOnAppear
        case selectInfoIndex(index: Int)
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewOnAppear:
            input.viewOnAppear.send(())
        case .selectInfoIndex(let index):
            input.selectedInfoIndex.send(index)
        }
    }
}
