//
//  SearchTableViewController.swift
//  SearchImageTest
//
//  Created by Sergio Veliz on 10/24/17.
//  Copyright © 2017 Sergio Veliz. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    // MARK: iOS 11
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let sc = UISearchController(searchResultsController: nil)
        navigationItem.searchController = sc
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - UITableViewDataSource conformance
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
//        cell.imageView?.image = indexPath.row.description
        cell.textLabel?.text = indexPath.row.description + "row"
        return cell
    }
    
    // MARK: - UITableViewDelegate conformance
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let dvc = segue.destination as! DetailsViewController
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                let selectedCell = tableView.cellForRow(at: indexPath),
                let cellLabelText = selectedCell.textLabel?.text else { return }
            
//            dvc.imageView = image
        }
    }
    
}
