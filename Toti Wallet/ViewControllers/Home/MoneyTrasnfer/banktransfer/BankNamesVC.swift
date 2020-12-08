//
//  BankNamesVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/8/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BankNamesVC: BaseVC {

    let repo:BeneficiaryRespository = BeneficiaryRespository()
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    
    var list:[BankName] = Array()
    var filteredList:[BankName] = Array()
    
    
    var delegate:BankNameProtocol!
    var payOutCountry:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBankNetwork()
    }
    
    
    func getBankNetwork()  {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = BankNameListRequest()
            request.languageId = preferenceHelper.getLanguage()
            request.shortCountryName = payOutCountry
            
            repo.getBankNamesList(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_BANK_NAME), completion: {(response , error ) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.list.removeAll()
                    self.filteredList.removeAll()
                    self.filteredList.append(contentsOf: response!.bankNames)
                    self.list.append(contentsOf: response!.bankNames)
                    self.searchTableView.reloadData()
                } else {
                    self.showError(message: response!.description)
                }
            })
        }
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
            let countryText: NSString = country.bankName as NSString
            
            return (countryText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        searchTableView.reloadData()
    }

}

//MARK : TableView Functions
extension BankNamesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].bankName
        cell.lblDetail.text = ""
        cell.imageView?.image = nil
        cell.imageView!.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectBank(bank: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }

}
