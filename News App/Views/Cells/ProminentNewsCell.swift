//
//  ProminentNewsCell.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import UIKit



class ProminentNewsCell: UITableViewCell {
    
    
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var teaserImageView: CustomImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    static let identifier = "ProminentNewsCell"
    
    private func setUpCardView() {
        cellBackgroundView.layer.cornerRadius = 10.0
        cellBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cellBackgroundView.layer.shadowRadius = 8.0
        cellBackgroundView.layer.shadowOpacity = 0.4
        
        teaserImageView.layer.cornerRadius = 10.0
    }
    
    func setUpCellWithSectionViewModel(_ section: SectionViewModel) {
        setUpCardView()
        
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
