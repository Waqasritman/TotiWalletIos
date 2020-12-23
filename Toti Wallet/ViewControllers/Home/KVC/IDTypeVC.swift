//
//  IDTypeVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/9/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class IDTypeVC: BaseVC {

    
    let repository:MoneyTransferRepository = MoneyTransferRepository()
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    
  
    @IBOutlet weak var pageTitle: UILabel!
    var filteredList:[IdType] = Array()
    var idType = ""
    
    var delegate:IdTypeProtocol!
    var shortCountryCode:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        getPurposeList()
        pageTitle.text = "selectid_type".localized
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func getPurposeList() {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request:GetIDTypeRequest = GetIDTypeRequest()
            request.countryShortName = idType
            request.languageId = preferenceHelper.getLanguage()
            
            repository.getIdTypes(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_ID), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                    self.btnBackFunc(self)
                } else if response!.responseCode == 101 {
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
    
  
}

//MARK : TableView Functions
extension IDTypeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].idTypeName
        cell.lblDetail.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectId(idType: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }
}
