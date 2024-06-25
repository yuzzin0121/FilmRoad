//
//  EditProfileViewModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

@MainActor
final class EditProfileViewModel<Repo: Repository>: ObservableObject where Repo.ITEM == ProfileRealmModel  {
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    private let repository: Repo
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var isMale: Bool = false
    @Published var phoneNumber: String = ""
    @Published var profileImage: UIImage?
    let validator = Validator()
    
    init(repository: Repo, profile: Profile?) {
        self.repository = repository
        transform()
        input.profile.send(profile)
    }
    
    private func transform() {
        input.viewOnAppear
            .combineLatest(input.profile)
            .sink { [weak self] (_, profile) in
                guard let self, let profile else { return }
                output.profile = profile
                nickname = profile.nickname ?? ""
                email = profile.email ?? ""
                isMale = profile.isMale ?? false
                phoneNumber = profile.phoneNumber ?? ""
            }
            .store(in: &cancellables)
        
        input.imageEditButtonTap
            .sink { [weak self] _ in
                guard let self else { return }
                output.isShowImagePicker = true
            }
            .store(in: &cancellables)
        
        $profileImage   // 프로필 이미지 변경 시
            .sink { [weak self] uiimage in
                guard let self else { return }
                Task {
                    await self.imageToData(uiimage)
                }
            }
            .store(in: &cancellables)
        
        $nickname
            .sink { [weak self] nickname in
                guard let self else { return }
                Task {
                    let trimmedNickname = nickname.trimmingCharacters(in: [" "])
                    let isValid = await self.validator.isValidNickname(nickname: trimmedNickname)
                    await self.setValid(isValid: isValid, warningMessage: "닉네임은 2 ~ 8글자로 입력")
                    self.output.profile?.nickname = trimmedNickname
                }
            }
            .store(in: &cancellables)
        
        $email
            .sink { [weak self] email in
                guard let self else { return }
                Task {
                    let trimmedEmail = email.trimmingCharacters(in: [" "])
                    let isValid = await self.validator.isValidEmail(email: trimmedEmail)
                    await self.setValid(isValid: isValid, warningMessage: "이메일은 @ 포함, 6글자 이상 입력")
                    self.output.profile?.email = trimmedEmail
                }
            }
            .store(in: &cancellables)
        
        $phoneNumber
            .sink { [weak self] phoneNumber in
                guard let self else { return }
                Task {
                    let trimmedPhoneNumber = phoneNumber.trimmingCharacters(in: [" "])
                    let isValid = await self.validator.isValidPhoneNumber(phoneNumber: trimmedPhoneNumber)
                    await self.setValid(isValid: isValid, warningMessage: "전화번호는 10 ~ 11 글자로 입력")
                    self.output.profile?.phoneNumber = trimmedPhoneNumber
                }
            }
            .store(in: &cancellables)
        
        $isMale
            .sink { [weak self] isMale in
                guard let self else { return }
                output.profile?.isMale = isMale
            }
            .store(in: &cancellables)
        
        input.editButtonTap
            .sink { [weak self] _ in
                guard let self else { return }
                Task {
                    guard let profileRealmModel = await self.getProfileRealmModel(profile: self.output.profile) else { return }
                    self.repository.updateItem(data: profileRealmModel)
                    self.output.editSuccess = true
                }
            }
            .store(in: &cancellables)
    }
    
    private func setValid(isValid: Bool, warningMessage: String) async {
        output.warningString = isValid ? "" : warningMessage
        output.isValid = isValid
    }
    
    private func imageToData(_ uiImage: UIImage?) async {
        guard let uiImage = uiImage else { return }
        let data = uiImage.jpegData(compressionQuality: 0.4)
        output.profile?.profileImageData = data
    }
    
    private func getProfileRealmModel(profile: Profile?) async -> ProfileRealmModel? {
        guard let profile else { return nil }
        let profileRealmModel = ProfileRealmModel(nickname: profile.nickname,
                                                  email: profile.email,
                                                  profileImageData: profile.profileImageData,
                                                  isMale: profile.isMale,
                                                  phoneNumber: profile.phoneNumber)
        profileRealmModel.id = profile.id
        return profileRealmModel
        
    }
}

extension EditProfileViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
        var profile = PassthroughSubject<Profile?, Never>()
        var imageEditButtonTap = PassthroughSubject<Void, Never>()
        var editButtonTap = PassthroughSubject<Void, Never>()
    }
    struct Output {
        var profile: Profile?
        var pickerConfig: PHPickerConfiguration {
            var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            config.filter = .images
            config.selectionLimit = 1
            config.preferredAssetRepresentationMode = .current
            return config
        }
        var isShowImagePicker: Bool = false
        var warningString: String = ""
        var isValid: Bool = false
        var editSuccess: Bool = false
    }
    
    enum Action {
        case viewOnAppear
        case imageEditButtonTap
        case editButtonTap
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewOnAppear:
            input.viewOnAppear.send(())
        case .imageEditButtonTap:
            input.imageEditButtonTap.send(())
        case .editButtonTap:
            input.editButtonTap.send(())
        }
    }
}
