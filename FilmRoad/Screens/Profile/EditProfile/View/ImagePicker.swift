//
//  ImagePicker.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import SwiftUI
import UIKit
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) var dismiss
    
    let configuration: PHPickerConfiguration
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let pickerController = PHPickerViewController(configuration: configuration)
        pickerController.delegate = context.coordinator
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            if !(results.isEmpty) {
                for result in results {
                    let itemProvider = result.itemProvider
                    
                    if itemProvider.canLoadObject(ofClass: UIImage.self) {
                        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                            guard let self else { return }
                            if let image = image as? UIImage {
                                Task {
                                    self.parent.image = image
                                }
                            }
                            
                            if error != nil {
                                return
                            }
                        }
                    } else {
                        print("이미지 가져오기 실패")
                    }
                }
            }
            parent.dismiss()
        }
    }
}
