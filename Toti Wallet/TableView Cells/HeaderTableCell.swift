//
//  HeaderTableCell.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 29/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class HeaderTableCell: UITableViewCell {

    var sideMenu:SideMenuVC!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var lblImage: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    
    
    func initView(sideMenu:SideMenuVC) {
        self.sideMenu = sideMenu
    }
    
    
    @IBAction func btnEditProfile(_ sender: Any) {
        self.sideMenu.goToEditProfile()
    }
    
    
}
