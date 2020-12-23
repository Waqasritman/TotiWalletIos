//
//  YLocationsVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/5/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class YLocationsVC:  BaseVC {
    
    @IBOutlet weak var searchTableView: UITableView!

    @IBOutlet weak var titlelbl: UILabel!
    var filteredList:[YLocations] = Array()
    
    
    var delegate:YLocationProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchTableView.delegate = self
        searchTableView.dataSource = self
        titlelbl.text = "select_location_txt".localized
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK : TableView Functions
extension YLocationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].locationName
       
        cell.lblDetail.text = ""
        cell.imageOutlet.isHidden = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectLocation(location: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }
}
