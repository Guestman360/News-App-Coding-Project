//
//  NewsCell.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let identifier = "NewsCell"
    
    private var views: [UIView] = []
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        let newsCellView = NewsCellRowView()
        newsCellView.teaserImageView.image = UIImage(systemName: "square.and.arrow.down")
        newsCellView.headlineLabel.text = "headline 1"
        newsCellView.summaryLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis id erat ut sapien hendrerit auctor."
        
        let newsCellView2 = NewsCellRowView()
        newsCellView2.teaserImageView.image = UIImage(systemName: "arrow.uturn.up")
        newsCellView2.headlineLabel.text = "headline 2"
        newsCellView2.summaryLabel.text = "Pellentesque lacinia, velit in bibendum tincidunt, justo sapien ultricies ante, et placerat elit nulla eu nibh."
        
        let newsCellView3 = NewsCellRowView()
        newsCellView3.teaserImageView.image = UIImage(systemName: "arrow.uturn.down")
        newsCellView3.headlineLabel.text = "headline 3"
        newsCellView3.summaryLabel.text = "Aliquam urna augue, finibus non dui eget, semper porttitor enim. In ultrices auctor ex nec egestas. Nulla volutpat, urna eu dictum facilisis, ligula erat molestie magna, at suscipit turpis sem quis leo."

        
        stackView.addArrangedSubview(newsCellView)
        stackView.addArrangedSubview(newsCellView2)
        stackView.addArrangedSubview(newsCellView3)
        
        self.layoutIfNeeded()
        
//        for view in views {
//            stackView.addArrangedSubview(view)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Add custom view nd add to stack view - ViewModel holds this data so we can pass from there
    func setUpCellWithSectionViewModel(_ section: SectionViewModel, _ row: Int) {
        let articlesToGroup = section.rowsForSection[row].items
        
        for article in articlesToGroup {
            // Idea is to pull all Article objects from RowItem.items and parsing each article one at a time we add the data to
            // a custom view and once filled we add to vertical stack view
            let newsCell = NewsCellRowView()
            newsCell.setUpNewsCellItemView(article)
            views.append(newsCell)
            
//            if let tease = article.tease,
//               let headline = article.headline,
//               let summary = article.summary{
//
//                let newsCellView = NewsCellRowView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 500))
//                newsCellView.teaserImageView.loadImage(with: tease)
//
//                let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold)]
//                let headlineAttributedText = NSMutableAttributedString(string: headline, attributes: attrs)
//                newsCellView.headlineLabel.attributedText = headlineAttributedText
//                newsCellView.summaryLabel.text = summary
//
//                views.append(newsCellView)
//            }
        }
    }
}
