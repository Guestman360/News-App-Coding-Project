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
        return viewModel.numberOfSections(section: .section)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionItems = self.sectionListViewModel.sectionItems[section].items else { return 0 }
        return sectionItems.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = self.sectionListViewModel else { return nil }
        return viewModel.sectionAtIndex(section).header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProminentNewsCell.identifier, for: indexPath) as! ProminentNewsCell

        let section = self.sectionListViewModel.sectionAtIndex(indexPath.section)
        cell.textLabel?.text = section.items[indexPath.row].headline

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
