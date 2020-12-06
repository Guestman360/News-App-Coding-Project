//
//  NewsCellRowView.swift
//  News App
//
//  Created by Matthew Guest on 12/4/20.
//

import UIKit

class NewsCellRowView: UIView {
    
    let NEWS_CELL_ROW_VIEW_XIB = "NewsCellRowView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var teaserImageView: CustomImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    private func initSubViews() {
        let nib = UINib(nibName: NEWS_CELL_ROW_VIEW_XIB, bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        self.addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setUpNewsCellItemView(_ article: Article) {
        if let tease = article.tease,
           let headline = article.headline,
           let summary = article.summary {

            self.teaserImageView.loadImage(with: tease)
//            let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)]
//            let headlineAttributedText = NSMutableAttributedString(string: headline, attributes: attrs)
//            self.headlineLabel.attributedText = headlineAttributedText
            self.headlineLabel.text = headline
            self.summaryLabel.text = summary
        }
    }
}
