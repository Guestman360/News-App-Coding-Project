//
//  NewsCell.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let identifier = "NewsCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Add custom view nd add to stack view
    func setUpCellWithSectionViewModel(_ section: SectionViewModel, _ row: Int) {
        let articlesToGroup = section.rowsForSection[row].items
        
        for articles in articlesToGroup {
            print(articles.headline)
            // Idea is to pull all Article objects from RowItem.items and parsing each article one at a time we add the data to
            // a custom view and once filled we add to vertical stack view
        }
        
//        if let articleRow = articleInSection?.items.first,
//           let tease = articleRow.tease,
//           let headline = articleRow.headline {
//
//            self.teaserImageView.loadImage(with: tease)
//            let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold)]
//            let headlineAttributedText = NSMutableAttributedString(string: headline, attributes: attrs)
//            self.headlineLabel.attributedText = headlineAttributedText
//            self.summaryLabel.text = articleRow.summary
//        }
    }
}
