//
//  WorkWithImages.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import Foundation
import CoreData
import UIKit
import SwiftUI


class ImageSaver: NSObject {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished")
    }

    func saveToDataModel(_ photoRobot: PhotoRobot){
        let photoRobot = PhotoRobot(context: managedObjectContext)

        photoRobot.image = photoRobot.image
        photoRobot.topPosition = photoRobot.topPosition
        photoRobot.midPosition = photoRobot.midPosition
        photoRobot.botPosition = photoRobot.botPosition
    }
}

class ImageCombiner {
    func combinePhotos(_ topImage: UIImage, _ middleImage: UIImage, _ bottomImage: UIImage) -> UIImage {
        let size = CGSize(width: topImage.size.width, height: topImage.size.height * 3)
        
        UIGraphicsBeginImageContext(size)
        
        let point = CGPoint(x: 0, y: 0)
        let middlePoint = CGPoint(x: 0, y: 111)
        let bottomPoint = CGPoint(x: 0, y: 222)
        
        topImage.draw(at: point)
        middleImage.draw(at: middlePoint)
        bottomImage.draw(at: bottomPoint)

        let finalImg = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return finalImg!
    }
}

class ImageConverter {
    func convertImageToData(img: UIImage) -> Data{
        var data = Data()
        
        data.append(img.jpegData(compressionQuality: 1)!)
        
        return data
    }

    func convertDataToImages(imageDataArray: [Data]) -> [UIImage] {
      var myImagesArray = [UIImage]()
      imageDataArray.forEach { (imageData) in
          myImagesArray.append(UIImage(data: imageData)!)
      }
      return myImagesArray
    }
}

class FilterPhotoRobotImages {
    var pictures = [String]()
    
    func filterTopPhotos(containsString: String) -> [UIImage]  {
        var images = [UIImage]()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        
        for item in items {
            if item.contains(containsString){
                let imageUrl = URL(fileURLWithPath: path).appendingPathComponent(item)
                let image = UIImage(contentsOfFile: imageUrl.path)
                
                images.append(image!)
                
            }
        }
    
        return images
    }
}
