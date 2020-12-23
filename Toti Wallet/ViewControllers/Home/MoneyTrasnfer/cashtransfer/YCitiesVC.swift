//
//  YCitiesVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/5/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class YCitiesVC: BaseVC {

  
    @IBOutlet weak var searchTableView: UITableView!

    
   
    @IBOutlet weak var toolTitle: UILabel!
    var filteredList:[YCities] = Array()
    
    
    var delegate:YCityProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchTableView.delegate = self
        searchTableView.dataSource = self
        toolTitle.text = "select_city_txt".localized
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   

}

//MARK : TableView Functions
extension YCitiesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].cityName
       
            cell.lblDetail.text = ""
        
        cell.imageOutlet.isHidden = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectYCity(city: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }
}
