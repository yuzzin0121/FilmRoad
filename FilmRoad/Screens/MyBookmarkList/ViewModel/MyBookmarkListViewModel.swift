//
//  MyBookmarkListViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/24/24.
//

import Foundation
import Combine

@MainActor
final class MyBookmarkListViewModel<Repo: Repository>: ObservableObject where Repo.ITEM == BookmarkedTV {
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    private let repository: Repo
    
    init(repository: Repo) {
        self.repository = repository
        transform()
    }
    
    deinit {
        print(String(describing: self) + "Deinit")
    }
    
    private  func transform() {
        input.viewOnAppear
            .sink { [weak self] _ in
                guard let self else { return }
                let bookmarkedTVList = fetchBookmarkedTVList()
                setTVList(bookmarkedTVList: bookmarkedTVList)
            }
            .store(in: &cancellables)
        
        input.cancelBookmark
            .sink { [weak self] tvId in
                guard let self else { return }
                repository.deleteItem(id: tvId)
                if let index = output.bookmarkedTVList.firstIndex(where: { $0.id == tvId }) {
                    output.bookmarkedTVList.remove(at: index)
                }
            }
            .store(in: &cancellables)
    }
    
    
    // 북마크된 TV 리스트 조회
    private func fetchBookmarkedTVList() -> [BookmarkedTV] {
        let bookmarkedTVList = repository.fetchItem()
        return bookmarkedTVList
    }
    
    // BookmarkedTV -> TV 리스트로 변경 후 output에 반영
    private func setTVList(bookmarkedTVList: [BookmarkedTV]) {
        let tvList = bookmarkedTVList.map {
            TV(id: $0.id, name: $0.name, originalName: $0.originalName, posterPath: $0.posterPath, backdropPath: $0.backdropPath, isBookmarked: true)
        }
        output.bookmarkedTVList = tvList
    }

}
extension MyBookmarkListViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
        var cancelBookmark = PassthroughSubject<Int, Never>()
    }
    struct Output {
        var bookmarkedTVList: [TV] = []
    }
    
    enum Action {
        case viewOnAppear
        case bookmarkButtonTap(tvId: Int)
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewOnAppear:
            input.viewOnAppear.send(())
        case .bookmarkButtonTap(let tvId):
            input.cancelBookmark.send(tvId)
        }
    }
}
