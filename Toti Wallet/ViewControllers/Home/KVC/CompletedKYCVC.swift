//
//  CompletedKYCVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/19/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CompletedKYCVC: BaseVC {


    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        preferenceHelper.setDocumentUploaded(value: true)
        // Do any additional setup after loading the view.
        finishBtn.layer.cornerRadius = 8
        pageTitle.text = "thanks_message_for_submitting".localized
        finishBtn.setTitle("finish_txt".localized, for: .normal)
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        gotoHome()
    }
    
    @IBAction func btnFinishClick(_ sender: Any) {
        gotoHome()
    }
   

}
