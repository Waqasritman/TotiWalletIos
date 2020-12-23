//
//  PurposeVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/4/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class PurposeVC: BaseVC {

    
    @IBOutlet weak var pageTitle: UILabel!
    let repository:MoneyTransferRepository = MoneyTransferRepository()
    
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    
   
    var filteredList:[PurposeOfTransfer] = Array()
    
    
    var purposeProtocol:TransferPurposeProtocol!
    var shortCountryCode:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.text = "select_the_purpose_txt".localized
        
        getPurposeList()
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func getPurposeList() {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request:PurposeOfTransferListRequest = PurposeOfTransferListRequest()
            request.shortCountryName = shortCountryCode
            request.languageId = preferenceHelper.getLanguage()
            
            repository.getPurposeList(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GetPurposeOfTransferResult), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                    self.btnBackFunc(self)
                } else if response!.responseCode == 101 {
                  
                    self.filteredList.append(contentsOf: response!.purposeList!)
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
extension PurposeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].purposeOfTransfer
       
        cell.lblDetail.text = ""
        
       
//        cell.imageOutlet.sd_setImage(with: URL(string: filteredList[indexPath.row].image_URL), placeholderImage: UIImage(named: "flag"))
//        cell.imageOutlet.makeImageCircle()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        purposeProtocol.onSelectTransferProtocol(purpose: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }
}
