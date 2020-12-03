//
//  SelectCountryVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 30/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import SDWebImage

class SelectCountryVC: BaseVC , UISearchBarDelegate {

    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var searchTableView: UITableView!

    
    var countriesList:[WRCountryList] = Array()
    var filteredList:[WRCountryList] = Array()
    
    
    var countryProtocol:CountryListProtocol!
    
    var codeShown = false;
    var isShowCurrency = false
    var countryType = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        
        if Network.isConnectedToNetwork() {
            showProgress()
            authRepo.getCountriesList(request: HTTPConnection.openConnection(stringParams: GetCountryListRequest.shared.getXML(), action: SoapActionHelper.shared.ACTION_GET_COUNTRY_LIST), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else {
                    if response?.responseCode == 101 {
                        self.countriesList.removeAll()
                        self.filteredList.removeAll()
                        if self.countryType > 0 {
                            if self.countryType == CountryParser.RECEIVE {
                                self.filteredList.append(contentsOf: CountryParser.getReceivingCountry(list: response!.wrCountryList!))
                                self.countriesList.append(contentsOf: CountryParser.getReceivingCountry(list: response!.wrCountryList!))
                            } else if self.countryType == CountryParser.SEND {
                                self.filteredList.append(contentsOf: CountryParser.getSendingCountry(list: response!.wrCountryList!))
                                self.countriesList.append(contentsOf: CountryParser.getSendingCountry(list: response!.wrCountryList!))
                            }
                        } else {
                            self.filteredList.append(contentsOf: response!.wrCountryList!)
                            self.countriesList.append(contentsOf: response!.wrCountryList!)
                        }
                        self.searchTableView.reloadData()

                    } else {
                        self.showError(message: response!.description!)
                    }
                }
            })
        } else {
            self.noInternet()
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
        filteredList = countriesList.filter({ (country) -> Bool in
            let countryText: NSString = country.countryName as NSString
            
            return (countryText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        searchTableView.reloadData()
    }

}

//MARK : TableView Functions
extension SelectCountryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].countryName
        if codeShown {
            cell.lblDetail.text = filteredList[indexPath.row].countryCode
        } else if isShowCurrency {
            cell.lblDetail.text = filteredList[indexPath.row].currencyShortName
        } else {
            cell.lblDetail.text = ""
        }
       
        cell.imageOutlet.sd_setImage(with: URL(string: filteredList[indexPath.row].url), placeholderImage: UIImage(named: "flag"))
        cell.imageOutlet.makeImageCircle()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countryProtocol.onSelectCountry(country: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }
}
