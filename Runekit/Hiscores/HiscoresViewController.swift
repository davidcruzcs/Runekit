//
//  HiscoresViewController.swift
//  Runekit
//
//  Created by David Cruz on 3/12/18.
//  Copyright © 2018 AppShuttle.io. All rights reserved.
//

import UIKit

class HiscoresViewController: UIViewController {
    
    var searchController: UISearchController!
    @IBOutlet weak var tableSearchHistory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchHistory()
        setUpSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
    }
    
    func setUpUI() {
        searchController.searchBar.tintColor = ThemeManager.shared.getThemeColor()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToPlayerFromHiscores" {
            let vc = segue.destination as! PlayerScoreViewController
            vc.playerName = sender as! String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HiscoresViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func setUpSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Player"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if !searchBarIsEmpty() {
            //TODO: filter search history by input
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        if let searchText = searchController.searchBar.text {
            if searchText.replacingOccurrences(of: " ", with: "").isEmpty {
                return true
            } else {
                return searchText.isEmpty
            }
        } else {
            return true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBarIsEmpty() {
            if let text = searchBar.text {
                self.performSegue(withIdentifier: "GoToPlayerFromHiscores", sender: text)
            }
        }
    }
    
}

extension HiscoresViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpSearchHistory() {
        tableSearchHistory.delegate = self
        tableSearchHistory.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellHistory", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
