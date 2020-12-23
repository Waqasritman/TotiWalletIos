//
//  SelectCurrencyVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/3/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SelectCurrencyVC: BaseVC  {

    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    
    @IBOutlet weak var pageTitle: UILabel!
    var countriesList:[RecCurrency] = Array()
    var filteredList:[RecCurrency] = Array()
    
    
    var currencyProtocol:CurrencyListProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
        pageTitle.text = "select_currecny".localized
        txtSearch.placeholder = "search".localized
   
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK : TableView Functions
extension SelectCurrencyVC: UITableViewDelegate, UITableViewDataSource {
    
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
extension SelectCurrencyVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let string1 = string
        let string2 = txtSearch.text!
        var finalString = ""
        
        if string.count > 0 { // if it was not delete character
            finalString = string2 + string1
        }
        else if string2.count > 0{ // if it was a delete character
            
            finalString = String(string2.dropLast())
        }
        
        filteredList.removeAll()
        filteredList = countriesList.filter { $0.currencyShortName.lowercased().hasPrefix(finalString.lowercased())}
        
        searchTableView.reloadData()
        return true
    }
    
}
