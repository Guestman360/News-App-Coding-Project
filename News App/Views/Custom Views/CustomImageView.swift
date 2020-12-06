//
//  CustomImageView.swift
//  News App
//
//  Created by Matthew Guest on 12/4/20.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageURLString: String?
    
    func loadImage(with urlString: String) {
        imageURLString = urlString
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        guard let unwrappedUrl = url else { return }
        
        URLSession.shared.dataTask(with: unwrappedUrl) { (data, response, _) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async { [unowned self] in
                imageCache.setObject(image, forKey: urlString as NSString)
                // NOTE: unowned reference is sometimes deallocated here
                self.image = image
            }
        }.resume()
    }
}
