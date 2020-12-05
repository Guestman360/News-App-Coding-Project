//
//  ArticleViewModel.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import Foundation
import UIKit

struct ArticleViewModel {
    private let article: Article
    
    var tease: URL? {
        guard let tease = self.article.tease else {
            return nil
        }
        return URL(string: tease)
    }
    
    var headline: String {
        return self.article.headline ?? ""
    }
    
    var summary: String {
        return self.article.summary ?? ""
    }
    
    init(_ article: Article) {
        self.article = article
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func download(
        from url: URL,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        placeholder: UIImage? = nil,
        completionHandler: ((UIImage?) -> Void)? = nil) {
        image = placeholder
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data) else {
                completionHandler?(nil)
                return
            }
            DispatchQueue.main.async { [unowned self] in
                self.image = image
                completionHandler?(image)
            }
        }.resume()
    }
}
