//
//  EditProfileView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import SwiftUI

struct EditProfileView<Repo: Repository>: View where Repo.ITEM == ProfileRealmModel {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel<Repo>
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 50)
                HStack {
                    VStack(spacing: 20) {
                        profileImage(data: viewModel.output.profile?.profileImageData)
                        editImageButton()
                        Spacer()
                            .frame(height: 40)
                        HStack {
                            VStack(alignment: .leading, spacing: 12) {
                                infoTitleText(title: "이름")
                                infoTitleText(title: "이메일")
                                infoTitleText(title: "성별")
                                infoTitleText(title: "전화번호")
                                Spacer()
                            }
                            Spacer()
                                .frame(width: 50)
                            VStack(alignment: .leading, spacing: 12){
                                ProfileTextField(infoText: $viewModel.name, placeholder: "이름")
                                ProfileTextField(infoText: $viewModel.email, placeholder: "이메일")
                                GenderMenu(isMale: $viewModel.isMale)
                                ProfileTextField(infoText: $viewModel.phoneNumber, placeholder: "전화번호")
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)    // default 버튼 지우기
            .navigationBar(title: {
                Text("프로필 수정")
                    .bold()
            }, leading: {
                Button{
                    dismiss()
                }label: {
                    Image(ImageString.arrowLeft)
                }
            }, trailing: {
            })
            .foregroundStyle(.white)
        }
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
    
    private func editImageButton() -> some View {
        Text("프로필 이미지 변경")
            .font(.system(size: 15))
            .foregroundStyle(.blue)
            .wrapToButton {
                print("프로필 이미지 변경")
            }
    }
    
    private func infoTitleText(title: String) -> some View {
        Text(title)
            .font(.system(size: 16).bold())
            .frame(height: 40)
    }
}

struct GenderMenu: View {
    @Binding var isMale: Bool
    
    var body: some View {
        Menu {
            Text("남")
                .wrapToButton {
                    isMale = true
                }
            Text("여")
                .wrapToButton {
                    isMale = false
                }
        } label: {
            HStack {
                Text(isMale ? "남" : "여")
                Spacer()
            }
            .padding(.leading, 5)
        }
        .frame(height: 40)
    }
}

struct ProfileTextField: View {
    @Binding var infoText: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if infoText.isEmpty {
                Text(placeholder)
                    .foregroundStyle(.gray)
                    .padding(.leading, 5)
            }
            TextField(placeholder, text: $infoText)
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
        }
        .frame(height: 40)
    }
}
