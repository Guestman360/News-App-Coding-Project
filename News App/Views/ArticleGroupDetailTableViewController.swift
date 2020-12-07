//
//  ArticleGroupDetailTableViewController.swift
//  News App
//
//  Created by Matthew Guest on 12/6/20.
//

import UIKit

class ArticleGroupDetailTableViewController: UITableViewController {
    
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        
        let article = articles[indexPath.row]
        if let teaserImage = article.tease {
            articleCell.articleImage.loadImage(from: teaserImage, placeHolder: UIImage(named: "placeholder"))
        }
        articleCell.configureCell(with: article)
        
        return articleCell
    }
}
