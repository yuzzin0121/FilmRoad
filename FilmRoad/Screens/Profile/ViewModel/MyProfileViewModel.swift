//
//  MyProfileViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import Foundation
import Combine

@MainActor
final class MyProfileViewModel<Repo: Repository>: ObservableObject where Repo.ITEM == ProfileRealmModel {
    var cancellables = Set<AnyCancellable>()
    
    private var input = Input()
    @Published var output = Output()
    private var repository: Repo
    
    init(repository: Repo) {
        self.repository = repository
        transform()
    }
    
    private func transform() {
        input.viewOnAppear
            .sink { [weak self] _ in
                guard let self else { return }
                let profileList = getProfile()
                if isEmptyProfile(profileList: profileList) {   // 프로필이 존재하지 않을 경우
                    createProfile()
                } else {
                    
                }
            }
            .store(in: &cancellables)
    }
    
    private func getProfile() -> [ProfileRealmModel] {
        return repository.fetchItem()
    }
    
    private func isEmptyProfile(profileList: [ProfileRealmModel]) -> Bool {
        return profileList.isEmpty
    }
    
    private func createProfile() {
        let profileRealmModel = ProfileRealmModel()
        repository.createItem(data: profileRealmModel)
    }
    
    private func setProfile(profileList: [ProfileRealmModel]) {
        output.profile = profileList.first
    }
}

extension MyProfileViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    struct Output {
        var profile: ProfileRealmModel?
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
