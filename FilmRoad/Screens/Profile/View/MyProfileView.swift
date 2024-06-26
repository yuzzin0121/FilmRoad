//
//  MyProfileView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct MyProfileView<Repo: Repository>: View where Repo.ITEM == ProfileRealmModel {
    @StateObject var viewModel: MyProfileViewModel<Repo>
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(height: 40)
                    HStack(alignment: .top) {
                        VStack(spacing: 2) {
                            profileImage(data: viewModel.output.profile?.profileImageData)
                            NavigationLink {
                                EditProfileView(viewModel: EditProfileViewModel(repository: ProfileRepository() as! Repo, profile: viewModel.output.profile), profileViewModel: viewModel)
                            } label: {
                                editProfileButton()
                            }
                        }
                        Spacer()
                            .frame(width: 20)
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                                .frame(height: 1)
                            nicknameText(nickname: viewModel.output.profile?.nickname ?? "닉네임 없음")
                            Spacer()
                                .frame(height: 4)
                            infoTextView(title: "이메일", info: viewModel.output.profile?.email)
                            genderText(isMale: viewModel.output.profile?.isMale)
                            infoTextView(title: "전화번호", info: viewModel.output.profile?.phoneNumber)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    bookmarkedTVCountText(nickname: viewModel.output.profile?.nickname, count: viewModel.output.bookmarkedTVCount)
                    Spacer()
                }
            }
            .navigationBar(title: {
            }, leading: {
                Text("Profile")
                    .font(.title).bold()
            }, trailing: {
            })
        }
        .foregroundStyle(.white)
        .task {
            viewModel.action(.viewOnAppear)
        }
    }
    
    private func bookmarkedTVCountText(nickname: String?, count: Int) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(nickname ?? "닉네임없음")님은")
            HStack(spacing: 0) {
                Text("\(count)개의 TV")
                    .font(.system(size: 17).bold())
                    .foregroundStyle(.blue)
                Text("를 북마크하고 있어요!")
                    .font(.system(size: 17))
                Spacer()
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(.darkGray)
        .clipShape(.rect(cornerRadius: 14))
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
    
    private func infoTextView(title: String, info: String?) -> some View {
        HStack(spacing: 4) {
            Text(title)
                .subTitleFont(.gray)
            Text(info ?? "")
                .subTitleFont(.white)
            Spacer()
        }
    }
    
    private func profileImage(data: Data?) -> some View {
        if let data, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
        } else {
            return Image(ImageString.defaultProfile)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
        }
    }
    
    private func editProfileButton() -> some View {
        Text("프로필 편집")
            .font(.system(size: 15))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.white, lineWidth: 1)
            }
            .padding()
    }
    
    private func nicknameText(nickname: String?) -> some View {
        Text(nickname ?? "닉네임 없음")
            .font(.system(size: 19)).bold()
            
    }
    
    private func genderText(isMale: Bool?) -> some View {
        guard let isMale else {
            return HStack {
                Text("성별")
                    .subTitleFont(.gray)
                Text("")
                    .subTitleFont(.white)
                Spacer()
            }
        }
        
        return HStack {
            Text("성별")
                .subTitleFont(.gray)
            Text("\(isMale ? "남" : "여")")
                .subTitleFont(.white)
            Spacer()
        }
    }
}
