//
//  NewsTableViewController.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let newsService: NewsService = NewsService()
    
    private var sectionListViewModel: SectionListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "NBC News"
        
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        
        fetchNewsFromService()
    }
    
    private func fetchNewsFromService() {
        newsService.fetchNews { (result) in
            switch result {
            case .success(let response):
                guard let data = response.data else {
                    return
                }
                self.sectionListViewModel = SectionListViewModel(sectionItems: data, type: .section)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = self.sectionListViewModel else { return 0 }
        return viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionItems = self.sectionListViewModel.sectionAtIndex(section).rowsForSection
        return sectionItems.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = self.sectionListViewModel else { return nil }
        return viewModel.sectionAtIndex(section).header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sectionListViewModel.sectionAtIndex(indexPath.section)
        if indexPath.row == 0 {
            let prominentNewsCell = tableView.dequeueReusableCell(withIdentifier: ProminentNewsCell.identifier, for: indexPath) as! ProminentNewsCell
            prominentNewsCell.setUpCellWithSectionViewModel(section)
            return prominentNewsCell
        }
        
        let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        newsCell.setUpCellWithSectionViewModel(section, indexPath.row)
        
        return newsCell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
