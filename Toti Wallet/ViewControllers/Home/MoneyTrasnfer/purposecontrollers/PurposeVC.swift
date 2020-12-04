//
//  PurposeVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/4/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class PurposeVC: BaseVC {

    
    let repository:MoneyTransferRepository = MoneyTransferRepository()
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    
    var countriesList:[RecCurrency] = Array()
    var filteredList:[RecCurrency] = Array()
    
    
    var currencyProtocol:CurrencyListProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        filteredList = countriesList.filter({ (country) -> Bool in
            let countryText: NSString = country.currencyName as NSString
            
            return (countryText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        searchTableView.reloadData()
    }

}

//MARK : TableView Functions
extension PurposeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].currencyShortName
       
            cell.lblDetail.text = ""
        
       
        cell.imageOutlet.sd_setImage(with: URL(string: filteredList[indexPath.row].image_URL), placeholderImage: UIImage(named: "flag"))
        cell.imageOutlet.makeImageCircle()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currencyProtocol.onSelectCurrency(currency: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }
}
