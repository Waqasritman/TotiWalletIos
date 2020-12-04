//
//  BankTransferConverterVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BankTransferConverterVC: BaseVC , CurrencyListProtocol {
    var beneDetails:BeneficiaryList!
    
    let calRequest:CalTransferRequest = CalTransferRequest()
    let moneyTransferRepo:MoneyTransferRepository = MoneyTransferRepository()
    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var viewFirstCurrency: UIView!
    @IBOutlet weak var viewSecondCurrency: UIView!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtsecond: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var stackCommission: UIStackView!
    @IBOutlet weak var lblPayable: UILabel!
    @IBOutlet weak var lblSendingAmmount: UILabel!
    @IBOutlet weak var lblCommission: UILabel!
    @IBOutlet weak var btnSource: UIButton!
    @IBOutlet weak var btnTransfer: UIButton!
    @IBOutlet weak var btnSendNow: UIButton!
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var viewPromo: UIView!
    @IBOutlet weak var txtPromo: UITextField!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var lblPayInCurrency:UILabel!
    @IBOutlet weak var lblPayOutCurrency:UILabel!
    @IBOutlet weak var payInFlag:UIImageView!
    
    
    var isPriceViewVisible = false
    var isWalletSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()

    }
    
    

    
    @IBAction func btnHidePriceFunc(_ sender: UIButton) {
        if isPriceViewVisible {
            stackCommission.isHidden = true
            isPriceViewVisible = false
            sender.setTitle("Show price break down", for: .normal)
        }
        else{
            stackCommission.isHidden = false
            isPriceViewVisible = true
            sender.setTitle("Hide price break down", for: .normal)
        }
    }
    
    
    
    @objc
    func btnSendingCurrency(_ sender:Any) {
      
        if Network.isConnectedToNetwork() {
            let walletCurrencyRequest = GetWalletCurrencyListRequest()
            walletCurrencyRequest.languageId = preferenceHelper.getLanguage()
            showProgress()
            moneyTransferRepo.getWalletCurrency(request: HTTPConnection.openConnection(stringParams: walletCurrencyRequest.getXML(), action: SoapActionHelper.shared.ACTION_GET_WALLET_CURRENCY), completion: {(response , error ) in
                if let error = error {
                    self.hideProgress()
                    self.showError(message: error)
                } else if response!.responseCode == 101  {
                    self.onCurrencyList(currencyList: response!.walletCurrencyList)
                } else {
                    self.hideProgress()
                    self.showError(message: response!.description)
                }
            })
            
        } else {
            self.noInternet()
        }
    }
    
    @IBAction func btnConvertFunc(_ sender: UIButton) {
        viewBottom.isHidden = false
        btnConvert.isHidden = true
    }
    
    @IBAction func btnNowFunc(_ sender: UIButton) {
        let nextVC = ControllerID.summaryVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func onSelectCurrency(currency: RecCurrency) {
        self.lblPayInCurrency.text =  currency.currencyShortName
        calRequest.payInCurrency = currency.currencyShortName
        calRequest.transferCurrency = currency.currencyShortName
        payInFlag.sd_setImage(with: URL(string: currency.image_URL), placeholderImage: UIImage(named: "flag"))
        txtsecond.text = ""
    }
    
    func onCurrencyList(currencyList: [RecCurrency]) {
        if currencyList.count == 1 {
            self.hideProgress()
           
            self.lblPayInCurrency.text =  currencyList[0].currencyShortName
            calRequest.payInCurrency = currencyList[0].currencyShortName
            calRequest.transferCurrency = currencyList[0].currencyShortName
           
            
        } else {
            self.hideProgress()
            let nextVC = ControllerID.selectCurrencyVC.instance
            (nextVC as! SelectCurrencyVC).currencyProtocol = self
            (nextVC as! SelectCurrencyVC).filteredList = currencyList
            (nextVC as! SelectCurrencyVC).countriesList = currencyList
            self.pushWithFullScreen(nextVC)
        }
        txtsecond.text = ""
    }
    
    
    func getRates() {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                self.showProgress()
                calRequest.transferAmount = txtFirst.text!
            
                calRequest.paymentMode = beneDetails.paymentMode
                print(calRequest.getXML())
                moneyTransferRepo.getRates(request: HTTPConnection.openConnection(stringParams: calRequest.getXML(), action: SoapActionHelper.shared.ACTION_CAL_TRANSFER), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.showRates(response: response!)
                      //  self.showSuccess(message: response!.description!)
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                self.noInternet()
            }
        }
       
    }
    
    
    func showRates(response:CalTransferResponse) {
        txtsecond.text = String(format: "%.02f", response.payoutAmount)
        lblPayable.text = String(format: "%.02f", response.totalPayable)
        lblSendingAmmount.text = String(format: "%.02f", response.payInAmount)
        lblCommission.text = String(format: "%.02f", response.commission)
        showViews()
    }
    
    func initDesign() {
        viewFirstCurrency.layer.cornerRadius = 8
        viewSecondCurrency.layer.cornerRadius = 8
        
        txtFirst.layer.cornerRadius = 8
        txtsecond.layer.cornerRadius = 8
        
        txtFirst.setLeftPaddingPoints(10)
        txtsecond.setLeftPaddingPoints(10)
        
        btnConvert.layer.cornerRadius = 8
        btnConvert.layer.borderWidth = 1
        btnConvert.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        btnSendNow.layer.cornerRadius = 8
        
        viewPromo.layer.cornerRadius = 8
        btnApply.layer.cornerRadius = 8
        btnApply.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnSource.layer.cornerRadius = 8
        btnTransfer.layer.cornerRadius = 8
        btnSendNow.layer.cornerRadius = 8
        
        btnSource.imageEdgeInsets.left = self.btnSource.frame.width - 25
        btnTransfer.imageEdgeInsets.left = self.btnTransfer.frame.width - 25
        
        viewPromo.layer.borderWidth = 0.5
        viewPromo.layer.borderColor = UIColor.black.cgColor
        
        txtPromo.setLeftPaddingPoints(10)
        
        let currencyGesture = UITapGestureRecognizer(target: self, action: #selector(btnSendingCurrency(_:)))
        viewFirstCurrency.addGestureRecognizer(currencyGesture)
        
        lblPayOutCurrency.text = beneDetails.payOutCurrency
        
        calRequest.payoutCurrency = beneDetails.payOutCurrency
    }
    
    
    func showViews() {
        viewBottom.isHidden = false
        btnConvert.isHidden = true
    }
    
    func hideViews() {
        viewBottom.isHidden = true
        btnConvert.isHidden = false
    }

}
