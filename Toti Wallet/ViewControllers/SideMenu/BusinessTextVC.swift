//
//  BusinessTextVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 02/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BusinessTextVC: UIViewController {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    var heading = ""
    var detailTxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblHeading.text = heading
        detailTextView.text = detailTxt
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
