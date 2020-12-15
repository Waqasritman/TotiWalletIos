//
//  MyCardsVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 30/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MyCardsVC: BaseVC {

    let repo:Repository = Repository()
    @IBOutlet weak var viewGooglePay: UIView!
    @IBOutlet weak var viewPaytm: UIView!
    @IBOutlet weak var loadCardsBtn: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
    var cardsList:[CardDetails] = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewGooglePay.layer.cornerRadius = 8
        viewPaytm.layer.cornerRadius = 8
       
    }
    
    
    @IBAction func btnAddNewCard(_ sender:Any) {
        let nextVC = ControllerID.addCreditCardVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnLoadCard(_ sender:Any) {
        getCustomerCards()
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        (tabBarController as! CustomTabBarController).selectedIndex = 0
    }
    
    
    func getCustomerCards() {
        if Network.isConnectedToNetwork() {
            self.showProgress()
            let request = GetCardDetailsRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.languageID = preferenceHelper.getLanguage()
            repo.loadCustomerCards(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CARD_DETAILS), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.cardsList.removeAll()
                    self.cardsList.append(contentsOf: response!.cardDetails)
                    self.cardTableView.reloadData()
                    self.cardTableView.isHidden = false
                    self.loadCardsBtn.isHidden = true
                } else {
                    self.showError(message: response!.description!)
                }
            })
        }
    }

}
//MARK : TableView Functions
extension MyCardsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! CardTableCell
        cell.viewMain.layer.cornerRadius = 8
        cell.lblCardNumber.text = cardsList[indexPath.row].cardNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
