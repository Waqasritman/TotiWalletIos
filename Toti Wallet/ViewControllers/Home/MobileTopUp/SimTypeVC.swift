//
//  SimTypeVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SimTypeVC: BaseVC {

    let repo:UtilityRepository = UtilityRepository()
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var toolTitle: UILabel!
    var list:[WRBillerType] = []
    var delegate:WRBillerNameProtocol!
    var countryCode:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        toolTitle.text = "select_type".localized
        
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = GetWRMobileTopupTypesRequest()
            request.languageId = preferenceHelper.getApiLangugae()
            request.countryCode = countryCode
            print(request.getXML())
            repo.getMobileTopUpTypes(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_WR_BILLER_TYPE_MOBILE), completion: {(response ,error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.list.removeAll()
                    self.list.append(contentsOf: response!.countriesList)
                    
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
extension SimTypeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        
        cell.lblTitle.text = list[indexPath.row].billerName
        cell.lblDetail.isHidden = true
        
        cell.imageOutlet.sd_setImage(with: URL(string:"https://183.87.134.37/IconsImages/Mobile Recharge.png"), placeholderImage: UIImage(named: "flag"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectBillerType(biller: list[indexPath.row])
        self.btnBackFunc(self)
    }
}
