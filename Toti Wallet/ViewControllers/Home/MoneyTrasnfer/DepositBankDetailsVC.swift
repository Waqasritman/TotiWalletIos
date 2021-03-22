//
//  DepositBankDetailsVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 2/15/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import UIKit

class DepositBankDetailsVC: BaseVC  {

    let repo :Repository = Repository()
    
    
    @IBOutlet weak var toolTitle: UILabel!
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var referNoTitlelbl: UILabel!
    @IBOutlet weak var referNolbl: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    
    @IBOutlet weak var doneBtn: UIButton!
    var bankList:[String] = Array()
    
    var receiptNumber:String = ""
    var isShowReceipt = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolTitle.text = "bank_details_txt".localized
        pageTitle.text = "bank_depost_message".localized
        referNoTitlelbl.text = "refer_no".localized
        
        doneBtn.layer.cornerRadius = 8
        doneBtn.setTitle("okay".localized, for: .normal)
        
     
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        
        
        let request = BankDepositDetailsNamesRequest()
        request.currencyShortName = preferenceHelper.getResidenseCountry()
        request.langugaeID = preferenceHelper.getApiLangugae()
        
        repo.getBankDetails(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_BANK_DEPOSIT_DETAILS), completion: {(response , error) in
            if let error = error {
                self.showError(message: error.localized)
            } else if response!.responseCode == 101 {
                self.splitData(list: response!.dataList!)
            } else if response!.description != nil {
                self.showError(message: response!.description)
            } else {
                self.showError(message: "something went wrong")
            }
        })
        
        
        
    }
    

    @IBAction func doneBtnClick(_ sender: Any) {
        if isShowReceipt {
            let nextVc = ControllerID.receiptVC.instance
            (nextVc as! ReceiptVC).tranactionNumber = receiptNumber
            (nextVc as! ReceiptVC).comeFromHome = false
            self.pushWithFullScreen(nextVc)
        } else {
            self.gotoHome()
        }
       
    }
    
    
    func splitData(list:[BankDepositDetails]) {
         bankList.removeAll()
        for BankDepositDetails in list {
            var string = BankDepositDetails.data.breakLine(sign: ",")
            string = string.breakLine(sign: ":")
            print(string)
            bankList.append(string)
        }
        self.tableView.reloadData()
    }
    
    
}


extension DepositBankDetailsVC: UITableViewDelegate, UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "depositBankCell") as! DepositBankCell
        cell.mainView.setCardView(radius: 3)
        cell.bankDetailLbl.text = bankList[indexPath.row]
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
 
}


class DepositBankCell : UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bankDetailLbl: UILabel!

    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
}
