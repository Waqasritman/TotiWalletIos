//
//  SwiftPurposeVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/16/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SwiftPurposeVC: BaseVC {

    @IBOutlet weak var searchTableView: UITableView!

    
    var list:[YLocations] = Array()
    var filteredList:[YLocations] = Array()
    

    let  arrForPurpose:[String] = ["Trade","Others"]
    
    var delegate:SwiftPurposeProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredList = list.filter({ (country) -> Bool in
            let countryText: NSString = country.locationName as NSString
            
            return (countryText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        searchTableView.reloadData()
    }

}

//MARK : TableView Functions
extension SwiftPurposeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForPurpose.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = arrForPurpose[indexPath.row]
       
        cell.lblDetail.text = ""
        cell.imageOutlet.isHidden = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.onSelectPurpose(purpose:arrForPurpose[indexPath.row] , index:indexPath.row)
        self.btnBackFunc(self)
    }
}
