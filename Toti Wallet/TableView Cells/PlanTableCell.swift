//
//  PlanTableCell.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class PlanTableCell: UITableViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblBillerName: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    


    @IBOutlet weak var namelbl: UILabel! {
        didSet{
            namelbl.text = "biller_name".localized
        }
    }
    @IBOutlet weak var amountlbl: UILabel! {
        didSet{
            amountlbl.text = "amount_payable".localized
        }
    }
    
    @IBOutlet weak var descriptionlbl: UILabel! {
        didSet{
            descriptionlbl.text = "description_txt_optional".localized
        }
    }
    
    
}
