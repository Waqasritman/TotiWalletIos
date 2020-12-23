//
//  ShareWthFriendVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 02/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ShareWthFriendVC: UIViewController {

    @IBOutlet weak var referalCodelbl: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var referMessagelbl: UILabel!
    @IBOutlet weak var shareReferallbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnShare.layer.cornerRadius = 8
        
        pageTitle.text = "share_and_earn".localized
        referalCodelbl.text = "text_Referral".localized
        referMessagelbl.text = "share_message".localized
        shareReferallbl.text = "msg_share_referral".localized
        btnShare.setTitle("text_share_with_friend".localized, for: .normal)
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
