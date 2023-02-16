//
//   IntegratingCoreImageView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 16/02/2023.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct IntegratingCoreImageView: View {
    @State private var image: Image?
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    func loadImage() {
        guard let inputImage = UIImage(named: "Image") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
}

struct IntegratingCoreImageView_Previews: PreviewProvider {
    static var previews: some View {
        IntegratingCoreImageView()
    }
}
