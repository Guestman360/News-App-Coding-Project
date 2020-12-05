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
    
    var tease: String {
        guard let tease = self.article.tease else {
            return ""
        }
        return tease
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
