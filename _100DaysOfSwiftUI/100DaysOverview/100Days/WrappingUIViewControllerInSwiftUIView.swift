//
//  WrappingUIViewControllerInSwiftUIView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 16/02/2023.
//

import SwiftUI

struct WrappingUIViewControllerInSwiftUIView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var isShowImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Button("Select image") {
                isShowImagePicker = true
            }
            .padding()
            Button("Save image") {
                guard let inputImage = inputImage else { return }
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { newValue in
            loadImage()
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct WrappingUIViewControllerInSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WrappingUIViewControllerInSwiftUIView()
    }
}
