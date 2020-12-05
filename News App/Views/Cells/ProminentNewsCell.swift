//
//  ProminentNewsCell.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import UIKit



class ProminentNewsCell: UITableViewCell {
    
    @IBOutlet weak var teaserImageView: CustomImageView!
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
    
    func setUpCellWithSectionViewModel(_ section: SectionViewModel) {
        let articleInSection = section.rowsForSection.first
        if let articleRow = articleInSection?.items.first,
           let tease = articleRow.tease,
           let headline = articleRow.headline {
            
            self.teaserImageView.loadImage(with: tease)
            let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold)]
            let headlineAttributedText = NSMutableAttributedString(string: headline, attributes: attrs)
            self.headlineLabel.attributedText = headlineAttributedText
            self.summaryLabel.text = articleRow.summary
        }
    }
}
