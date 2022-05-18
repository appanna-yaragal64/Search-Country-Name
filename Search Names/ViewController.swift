//
//  ViewController.swift
//  Search Names
//
//  Created by Appanna Yaragal on 17/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var countryListTableView: UITableView!
    var isSearchActive: Bool = false
    
    var countryList: [String] = []
    var filteredCountryList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Country List"
        
        countryList = ["Afghanistan", "Albania", "Algeria", "Bahrain", "Bangladesh", "Barbados", "Cambodia", "Cameroon", "Canada", "Denmark", "Djibouti", "East timor", "Ecuador", "Falkland islands", "Finland", "Gabon", "Georgia", "Haiti", "Honduras", "Iceland", "India", "Iraq", "Jamaica", "Kazakhstan", "Laos"]
    }
}

//MARK: - UITableView Delegate & UITableView DataSource Methods
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive {
            return filteredCountryList.count
        } else {
            return countryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as! CountryListTableViewCell
        
        let countryName = isSearchActive ? filteredCountryList[indexPath.row] : countryList[indexPath.row]
        cell.countryNameLabel.text = countryName
        return cell
    }
}

//MARK: - UISearchBar Delegate Methods
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearchActive = searchText.count > 0 ? true : false
        self.searchBar(searchText: searchText)

        countryListTableView.reloadData()
    }
    
    //Search country list
    func searchBar(searchText: String) {
        filteredCountryList = searchText.isEmpty ? countryList : countryList.filter { $0.contains(searchText) }
        self.countryListTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
