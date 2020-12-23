//
//  SwiftPurposeVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/16/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SwiftPurposeVC: BaseVC {

    @IBOutlet weak var searchTableView: UITableView!

    
    @IBOutlet weak var tooltitle: UILabel!
   
    var filteredList:[YLocations] = Array()
    

    let  arrForPurpose:[String] = ["Trade","Others"]
    
    var delegate:SwiftPurposeProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchTableView.delegate = self
        searchTableView.dataSource = self
        tooltitle.text = "select_the_purpose_txt".localized
        
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK : TableView Functions
extension SwiftPurposeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForPurpose.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = arrForPurpose[indexPath.row]
       
        cell.lblDetail.text = ""
        cell.imageOutlet.isHidden = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.onSelectPurpose(purpose:arrForPurpose[indexPath.row] , index:indexPath.row)
        self.btnBackFunc(self)
    }
}
