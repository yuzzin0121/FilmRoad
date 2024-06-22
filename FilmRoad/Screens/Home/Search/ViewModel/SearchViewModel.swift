//
//  SearchViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    init() {
        transform()
    }
    
    private func transform() {
        $query
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .filter { !$0.trimmingCharacters(in: [" "]).isEmpty }
            .sink { [weak self] query in
                print(query)
                guard let self else { return }
                Task {
                    await self.searchTV(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    private func searchTV(query: String) async {
        print(#function)
        do {
            let tvResponseModel = try await TMDBNetworkManager.shared.requestToTMDB(model: TVResponseModel.self, router: TMDBRouter.tvSearch(query: query))
            print(tvResponseModel)
            print(tvResponseModel.totalResults)
            output.searchedTVList = tvResponseModel.results
        } catch {
            print(error)
        }
    }
}
extension SearchViewModel {
    struct Input {
    }
    struct Output {
        var searchedTVList: [TV] = []
    }
    
    enum Action {
    }
    
    func action(_ action: Action) {
        switch action {
        }
    }
}
