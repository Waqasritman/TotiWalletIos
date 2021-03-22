//
//  SettingsVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 01/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    
    let tableData = ["terms".localized, "privacy".localized , "FAQ".localized]
    let headingData = ["terms_text".localized ,"privacy_txt".localized , "".localized]
    let tableImages = [#imageLiteral(resourceName: "sideMenuInfo"),#imageLiteral(resourceName: "sideMenuInfo"),#imageLiteral(resourceName: "sideMenuInfo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK : TableView Functions
extension SettingsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! CountryTableCell
        cell.lblTitle.text = tableData[indexPath.row]
        cell.imageOutlet.image = tableImages[indexPath.row]
        cell.lblDetail.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let nextVC = ControllerID.faqVc.instance
            self.pushWithFullScreen(nextVC)
        } else {
            let nextVC = ControllerID.businessTextVC.instance
            (nextVC as! BusinessTextVC).heading = tableData[indexPath.row]
            (nextVC as! BusinessTextVC).detailTxt = headingData[indexPath.row]
            self.pushWithFullScreen(nextVC)
        }
       
    }
}
