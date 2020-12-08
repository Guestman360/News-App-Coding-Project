//
//  ArticleCell.swift
//  News App
//
//  Created by Matthew Guest on 12/6/20.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    static let identifier = "ArticleCellIdentifier"
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var openLinkInBrowserButton: UIButton!
    
    var articleUrl: String = ""
    
    @IBAction func openLinkInBrowser(_ sender: Any) {
        if let url = URL(string: articleUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    func configureCell(with article: Article) {
        if let teaserUrlString = article.tease,
           let headline = article.headline,
           let summary = article.summary,
           let articleUrl = article.url {

            self.articleImage.loadImage(from: teaserUrlString, placeHolder: UIImage(named: Constants.PLACEHOLER_IMAGE))
            self.headlineLabel.text = headline
            self.summaryLabel.text = summary
            self.articleUrl = articleUrl
        }
    }

}
