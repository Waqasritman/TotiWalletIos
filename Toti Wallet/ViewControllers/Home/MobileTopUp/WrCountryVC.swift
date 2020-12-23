//
//  WrCountryVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class WrCountryVC: BaseVC {

    let repo:UtilityRepository = UtilityRepository()
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var toolTitle: UILabel!
    
    var countriesList:[WRCountry] = []
    var delegate:WRCountryListProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        toolTitle.text = "select_country".localized
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = GetWRCountryListRequest()
            request.languageId = preferenceHelper.getLanguage()
            
            repo.getWRCountries(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_WR_COUNTRY), completion: {(response ,error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.countriesList.removeAll()
                    self.countriesList.append(contentsOf: response!.countriesList)
                    
                    self.searchTableView.reloadData()
                } else {
                    self.showError(message: response!.description!)
                }
            })
        } else {
            self.noInternet()
            self.btnBackFunc(self)
        }
        
    }
    
    
    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK : TableView Functions
extension WrCountryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        
        cell.lblTitle.text = countriesList[indexPath.row].countryName
        cell.lblDetail.isHidden = true
        
        cell.imageOutlet.sd_setImage(with: URL(string: countriesList[indexPath.row].image_URL), placeholderImage: UIImage(named: "flag"))
        cell.imageOutlet.makeImageCircle()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectCountry(country: countriesList[indexPath.row])
        self.btnBackFunc(self)
    }
}
