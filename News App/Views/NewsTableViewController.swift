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

        self.title = "The News App"
        
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.tintColor = .white
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0, blue: 0.5843137255, alpha: 1)
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        searchBarSetup()
        
        fetchNewsFromService()
    }
    
    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 70))
        searchBar.showsScopeBar = true
        searchBar.selectedScopeButtonIndex = 0
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        self.tableView.tableHeaderView = searchBar
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToArticleDetail", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            print("Something went wrong when selected a row!")
            return
        }
        
        let section = selectedIndexPath.section
        let row = selectedIndexPath.row
        let sectionItems = self.sectionListViewModel.sectionAtIndex(section).rowsForSection
        let articles = sectionItems[row].items
        
        let destinationVC = segue.destination as! ArticleGroupDetailTableViewController
        destinationVC.articles = articles
    }
}

extension NewsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredSections = sectionListViewModel.filteredSectionItemsList().filter { ($0.header?.lowercased().contains(searchText.lowercased()) ?? false) }
        sectionListViewModel.filteredSectionItems = filteredSections
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        sectionListViewModel.filteredSectionItems = sectionListViewModel.sectionItems
        searchBar.text?.removeAll()
        searchBar.endEditing(true)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
