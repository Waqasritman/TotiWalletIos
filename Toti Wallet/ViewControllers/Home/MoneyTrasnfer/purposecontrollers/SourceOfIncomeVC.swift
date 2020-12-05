//
//  SourceOfIncomeVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/4/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SourceOfIncomeVC: BaseVC {

 
    let repository:MoneyTransferRepository = MoneyTransferRepository()
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    
    var list:[SourceOfIncome] = Array()
    var filteredList:[SourceOfIncome] = Array()
    
    
    var delegate:SourceOFIncomeProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        getSourceOfIncome()
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getSourceOfIncome()  {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request:GetSourceIncomeListRequest = GetSourceIncomeListRequest()
            request.languageId = preferenceHelper.getLanguage()
            
            repository.getSourceOfIncome(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_SOURCE_OF_INCOME), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                    self.btnBackFunc(self)
                } else if response!.responseCode == 101 {
                    self.list.append(contentsOf: response!.idTypeList!)
                    self.filteredList.append(contentsOf: response!.idTypeList!)
                    self.searchTableView.reloadData()
                } else {
                    self.showError(message: response!.description)
                    self.btnBackFunc(self)
                }
            })
            
        } else {
            self.noInternet()
            self.btnBackFunc(self)
        }
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredList = list.filter({ (country) -> Bool in
            let countryText: NSString = country.incomeName as NSString
            
            return (countryText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        searchTableView.reloadData()
    }

}

//MARK : TableView Functions
extension SourceOfIncomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].incomeName
       
        cell.lblDetail.text = ""
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectSourceOfIncome(sourceOfIncome: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }

}
