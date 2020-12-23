//
//  RelationVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/5/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class RelationVC: BaseVC {

    
    @IBOutlet weak var pageTitle: UILabel!
    let repository:AuthRepository = AuthRepository()
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    
   
    var filteredList:[Relation] = Array()
    
    
    var delegate:RelationProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.text = "plz_select_relation".localized
        getPurposeList()
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func getPurposeList() {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request:GetRelationListRequest = GetRelationListRequest()
            request.languageId = preferenceHelper.getLanguage()
        
            
            repository.getRealationList(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_RELATION_SHIP_LIST), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                    self.btnBackFunc(self)
                } else if response!.responseCode == 101 {
                  
                    self.filteredList.append(contentsOf: response!.relationList!)
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
extension RelationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].relationName
       
        cell.lblDetail.text = ""
        
       
//        cell.imageOutlet.sd_setImage(with: URL(string: filteredList[indexPath.row].image_URL), placeholderImage: UIImage(named: "flag"))
//        cell.imageOutlet.makeImageCircle()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectRelation(relation: filteredList[indexPath.row])
       // purposeProtocol.onSelectTransferProtocol(purpose: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }
}
