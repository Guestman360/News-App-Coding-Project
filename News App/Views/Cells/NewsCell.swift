//
//  NewsCell.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let identifier = "NewsCell"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        while let first = stackView.arrangedSubviews.first {
            stackView.removeArrangedSubview(first)
            first.removeFromSuperview()
        }
        stackView.removeFromSuperview()
    }
    
    func setUpCellWithSectionViewModel(_ section: SectionViewModel, _ row: Int) {
        addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true

        let articlesToGroup = section.rowsForSection[row].items

        for article in articlesToGroup {
            let newsCell = NewsCellRowView()
            newsCell.setUpNewsCellItemView(article)
            stackView.addArrangedSubview(newsCell)
        }
        self.layoutIfNeeded()
    }
}
