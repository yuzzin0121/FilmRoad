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
    private let bookmarkedTVRepository = BookmarkedTVRepository()
    
    init(repository: Repo) {
        self.repository = repository
        transform()
    }
    
    private func transform() {
        input.viewOnAppear
            .sink { [weak self] _ in
                guard let self else { return }
                Task {
                    let profileList = await self.getProfile()
                    if await self.isEmptyProfile(profileList: profileList) {   // 프로필이 존재하지 않을 경우
                        await self.createProfile()
                    } else {
                        await self.setProfile(profileList: profileList)
                    }
                }
                Task {
                    await self.fetchBookmarkedTVCount()
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchBookmarkedTVCount() async {
        let count = bookmarkedTVRepository.fetchItem().count
        output.bookmarkedTVCount = count
    }
    
    private func getProfile() async -> [ProfileRealmModel] {
        return repository.fetchItem()
    }
    
    private func isEmptyProfile(profileList: [ProfileRealmModel]) async -> Bool {
        return profileList.isEmpty
    }
    
    private func createProfile() async {
        let profileRealmModel = ProfileRealmModel()
        repository.createItem(data: profileRealmModel)
        output.profile = getProfile(profileRealmModel: profileRealmModel)
    }
    
    private func setProfile(profileList: [ProfileRealmModel]) async {
        if let profileRealmModel = profileList.first {
            output.profile = getProfile(profileRealmModel: profileRealmModel)
        }
    }
    
    private func getProfile(profileRealmModel: ProfileRealmModel) -> Profile {
        return Profile(id: profileRealmModel.id,
                       nickname: profileRealmModel.nickname,
                       email: profileRealmModel.email,
                       profileImageData: profileRealmModel.profileImageData,
                       isMale: profileRealmModel.isMale,
                       phoneNumber: profileRealmModel.phoneNumber)
    }
}

extension MyProfileViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    struct Output {
        var profile: Profile?
        var bookmarkedTVCount: Int = 0
        var settingList: [SettingItem] = SettingItem.allCases
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
