//
//  EditProfileViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import Foundation
import Combine

@MainActor
final class EditProfileViewModel<Repo: Repository>: ObservableObject where Repo.ITEM == ProfileRealmModel  {
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    private let repository: Repo
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var isMale: Bool = false
    @Published var phoneNumber: String = ""
    
    init(repository: Repo, profile: ProfileRealmModel?) {
        self.repository = repository
        transform()
        input.profile.send(profile)
    }
    
    private func transform() {
        input.viewOnAppear
            .combineLatest(input.profile)
            .sink { [weak self] (_, profile) in
                guard let self else { return }
                output.profile = profile
            }
            .store(in: &cancellables)
    }
}

extension EditProfileViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
        var profile = PassthroughSubject<ProfileRealmModel?, Never>()
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
