//
//  ImageSaver.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 16/02/2023.
//

import UIKit

class ImageSaver: NSObject {
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSaveWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save image finished")
    }
}
