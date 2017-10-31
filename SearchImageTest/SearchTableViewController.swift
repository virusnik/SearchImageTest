//
//  SearchTableViewController.swift
//  SearchImageTest
//
//  Created by Sergio Veliz on 10/24/17.
//  Copyright © 2017 Sergio Veliz. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage

class SearchTableViewController: UITableViewController {
    
    var searchResponse = SearchResponse()
    
    var timer: Timer?
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Image"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        // Setup the Scope Bar
        searchController.searchBar.delegate = self
        
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultTableViewCell
        let row = indexPath.row
        cell.setData(item: searchResponse.items[row])
        
        return cell
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let row = indexPath.row
                
                let controller = segue.destination as! DetailsViewController
                controller.item = searchResponse.items[row]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    
    // MARK: - Requests
    func createRequestByTimer() {
        guard let text = searchController.searchBar.text else {return}
        if text.count >= 3 {
            if timer != nil {
                timer!.invalidate()
                timer = nil
            }
            timer = Timer.scheduledTimer(timeInterval: 0.4, target:self, selector: #selector(SearchTableViewController.getSearchResult), userInfo: nil, repeats: false)
        }
    }
    
    @objc func getSearchResult() {
        let url = "https://www.googleapis.com/customsearch/v1"
        let apiKey = "AIzaSyBgro9aElBWeOJZ3SrqtKBmG6FQeX-x-ag"
        
        let params:[String: Any] = [
            "q": searchController.searchBar.text ?? "",
            "cx": "009915541123162100356:khwrdsodily",
            "key": apiKey,
            "searchType": "image"
        ]
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { [weak self]
            response in
            guard let selfNotNil = self else {return}
            switch response.result {
            case .success:
                if let responseValue = response.result.value {
                    if let response = Mapper<SearchResponse>().map(JSONObject: responseValue) {
                        selfNotNil.searchResponse = response
                        selfNotNil.tableView.reloadData()
                    }
                    else {
                        print("not found")
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        createRequestByTimer()
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        _ = searchController.searchBar
        createRequestByTimer()
    }
}
