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
                    HStack {
                        Spacer()
                            .frame(width: 10)
                        VStack(spacing: 4) {
                            profileImage(data: viewModel.output.profile?.profileImageData)
                            NavigationLink {
                                EditProfileView(viewModel: EditProfileViewModel(repository: ProfileRepository() as! Repo, profile: viewModel.output.profile), profileViewModel: viewModel)
                            } label: {
                                editProfileButton()
                            }
                            Spacer()
                        }
                        Spacer()
                            .frame(width: 20)
                        VStack(alignment: .leading, spacing: 6) {
                            Spacer()
                                .frame(height: 1)
                            nicknameText(nickname: viewModel.output.profile?.nickname ?? "닉네임 없음")
                            Spacer()
                                .frame(height: 4)
                            Text("이메일 \(viewModel.output.profile?.email ?? "")")
                                .subTitleFont()
                            genderText(isMale: viewModel.output.profile?.isMale)
                            Text("전화번호 \(viewModel.output.profile?.phoneNumber ?? "")")
                                .subTitleFont()
                            Spacer()
                        }
                        Spacer()
                    }
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
            .padding(.vertical, 6)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
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
            return Text("성별")
                .subTitleFont()
        }
        
        return Text("성별 \(isMale ? "남" : "여")")
            .subTitleFont()
    }
}
