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
    @IBOutlet weak var teaserImageView: UIImageView!
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
        if let teaserUrlString = article.tease,
           let headline = article.headline,
           let summary = article.summary {

            self.teaserImageView.loadImage(from: teaserUrlString, placeHolder: UIImage(systemName: "placeholder"))
            self.headlineLabel.text = headline
            self.summaryLabel.text = summary
        }
    }
}
