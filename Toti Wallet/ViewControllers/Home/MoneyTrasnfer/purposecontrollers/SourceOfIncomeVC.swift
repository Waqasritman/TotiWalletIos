//
//  SourceOfIncomeVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/4/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SourceOfIncomeVC: BaseVC {

 
    @IBOutlet weak var pageTitle: UILabel!
    let repository:MoneyTransferRepository = MoneyTransferRepository()
 
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    
   
    var filteredList:[SourceOfIncome] = Array()

    var delegate:SourceOFIncomeProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.text = "select_the_purpose_txt".localized
        getSourceOfIncome()
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getSourceOfIncome()  {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request:GetSourceIncomeListRequest = GetSourceIncomeListRequest()
            request.languageId = preferenceHelper.getApiLangugae()
            
            repository.getSourceOfIncome(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_SOURCE_OF_INCOME), completion: {(response , error) in
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
