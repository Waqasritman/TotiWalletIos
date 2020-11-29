//
//  SideMenuVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 29/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var sideTableView: UITableView!
    
    let sideTableData = ["Business Transaction", "Change PIN", "My Beneficiary List", "Pay via QR Code", "My QR Code", "Bill Payment", "Loyalty Points" ,"Refer to Friends", "Settings", "Logout"]
    
    let sideTableImages = [UIImage(named: "SideMenuQRCode"), UIImage(named: "SideMenuQRCode"), UIImage(named: "SideMenuQRCode"), UIImage(named: "SideMenuQRCode"), UIImage(named: "sideMenuQRCode2"), UIImage(named: "sideMenuBill"), UIImage(named: "sideMenuLoyalty"), UIImage(named: "sideMenuShare"), UIImage(named: "sideMenuInfo") ,UIImage(named: "sideMenuLogout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideTableView.delegate = self
        sideTableView.dataSource = self
        
    }
    
}

//MARK : TableView Functions
extension SideMenuVC: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell2")
        cell?.textLabel?.text = sideTableData[indexPath.row]
        cell?.imageView?.image = sideTableImages[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell") as! HeaderTableCell
        headerCell.btnImage.layer.cornerRadius = headerCell.btnImage.frame.height/2
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if sideTableData[indexPath.row] == "Business Transaction" {
            
        }
        else if sideTableData[indexPath.row] == "Change PIN"{
            
        }
        else if sideTableData[indexPath.row] == "My Beneficiary List"{
            
        }
        else if sideTableData[indexPath.row] == "Pay via QR Code"{
            
        }
        else if sideTableData[indexPath.row] == "My QR Code"{
            
        }
        else if sideTableData[indexPath.row] == "Bill Payment"{
            
        }
        else if sideTableData[indexPath.row] == "Loyalty Points"{
            
        }
        else if sideTableData[indexPath.row] == "Refer to Friends"{
            
        }
        else if sideTableData[indexPath.row] == "Settings"{
           
        }
        else if sideTableData[indexPath.row] == "Logout"{
            
        }
    }
}
