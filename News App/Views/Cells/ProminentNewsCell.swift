//
//  ProminentNewsCell.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import UIKit



class ProminentNewsCell: UITableViewCell {
    
    @IBOutlet weak var teaserImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    static let identifier = "ProminentNewsCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpCellWithViewModel(_ article: ArticleViewModel) {
//        if let articleTeaserImage = article.tease {
//            DispatchQueue.main.async {
//                self.teaserImageView.download(from: articleTeaserImage, contentMode: .scaleAspectFill)
//            }
//        }
        if let articleTeaserImage = article.tease {
            self.teaserImageView.load(url: articleTeaserImage)
        }
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold)]
        let headlineAttributedText = NSMutableAttributedString(string: article.headline, attributes: attrs)
        self.headlineLabel.attributedText = headlineAttributedText //article.headline
        self.summaryLabel.text = article.summary
    }
}
