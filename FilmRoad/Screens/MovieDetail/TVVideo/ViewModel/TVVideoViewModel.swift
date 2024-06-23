//
//  TVVideoViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/23/24.
//

import Foundation
import Combine

@MainActor
final class TVVideoViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    init(seriesId: Int?) {
        transform()
        input.seriesId.send(seriesId)
    }
    
    private func transform() {
        input.viewOnAppear
            .combineLatest(input.seriesId)
            .sink { [weak self] (_, seriesId) in
                guard let self, let seriesId else { return }
                Task {
                    await self.fetchVideoURL(seriesId: seriesId)
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchVideoURL(seriesId: Int) async {
        do {
            let videoResponseModel = try await TMDBNetworkManager.shared.requestToTMDB(model: VideoResponseModel.self, router: TMDBRouter.video(seriesId: seriesId))
            output.videoURL = getVideoURLString(videoList: videoResponseModel.results)
        } catch {
            return
        }
    }
    
    private func getVideoURLString(videoList: [Video]) -> String? {
        if let video = videoList.first {
            let urlString = APIKey.videoBaseURL.rawValue + video.key
            print(urlString)
            return urlString
        } else {
            print("비디오 없음")
            return nil
        }
    }
}

extension TVVideoViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
        var seriesId = PassthroughSubject<Int?, Never>()
    }
    struct Output {
        var videoURL: String?
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
