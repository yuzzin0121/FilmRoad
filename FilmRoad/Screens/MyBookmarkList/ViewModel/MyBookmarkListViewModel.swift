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
    
    private  func transform() {
        input.viewOnAppear
            .sink { [weak self] _ in
                guard let self else { return }
                let bookmarkedTVList = fetchBookmarkedTVList()
                setTVList(bookmarkedTVList: bookmarkedTVList)
            }
            .store(in: &cancellables)
    }
    
    private func fetchBookmarkedTVList() -> [BookmarkedTV] {
        let bookmarkedTVList = repository.fetchItem()
        return bookmarkedTVList
    }
    
    private func setTVList(bookmarkedTVList: [BookmarkedTV]) {
        let tvList = bookmarkedTVList.map {
            TV(id: $0.id, name: $0.name, originalName: $0.originalName, posterPath: $0.posterPath, backdropPath: $0.backdropPath)
        }
        output.bookmarkedTVList = tvList
    }

}
extension MyBookmarkListViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    struct Output {
        var bookmarkedTVList: [TV] = []
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
