//
//  MedSearchTableViewController.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MedSearchTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MedSearchController.shared.getMedNames(by: searchText) { (suggestionsResult) in
            DispatchQueue.main.async {
                guard let suggestion = suggestionsResult else { return }
                self.suggestions = suggestion
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background_1.jpg")!)
    }

    var suggestions: [String] = []
    

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return suggestions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell", for: indexPath)
        
        let suggestion = suggestions[indexPath.row]
        cell.textLabel?.text = suggestion
        cell.backgroundColor = .clear

        return cell
    }
 

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputMeds" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? MedAddTableViewController else { return }
            let sugggetion = suggestions[indexPath.row]
            destinationVC.medName = sugggetion
        }
    }
 

}
