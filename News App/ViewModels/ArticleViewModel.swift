//
//  ArticleViewModel.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import Foundation

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
