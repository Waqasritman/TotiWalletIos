//
//  PrepardCardVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class PrepardCardVC: BaseVC {

    let repo:Repository = Repository()
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var btnMyCards: UIButton!
    @IBOutlet weak var btnLoadCard: UIButton!
    @IBOutlet weak var viewLoadCard: UIView!
    @IBOutlet weak var btn100: UIButton!
    @IBOutlet weak var btn200: UIButton!
    @IBOutlet weak var btn300: UIButton!
    @IBOutlet weak var btn400: UIButton!
    @IBOutlet weak var btn500: UIButton!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var loadtitle: UILabel!
    
   
    @IBOutlet weak var loadViewb: UIView!
    @IBOutlet weak var generateLoadCardBtn: UIButton!
    
    var customerCardNo:String = ""
    
    
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var pageTitlelbl: UILabel!
    @IBOutlet weak var pickamountlbl: UILabel!
    
    
    override func isValidate() -> Bool {
        if txtAmount.text!.isEmpty {
            showError(message: "enter_the_amount".localized)
            return false
        } else if customerCardNo.isEmpty {
            showError(message: "plz_generate_your_card".localized)
            return false
        }
        else if Double(txtAmount.text!)! < 25 {
            showError(message: "maximum_amount_of_top_is_2000".localized)
            return false
        } else if Double(txtAmount.text!)! > 900 {
            showError(message: "maximum_amount_of_top_is_2000".localized)
            return false
        }
         return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadtitle.text = "maximum_amount_of_top_is_2000".localized
        toolTitle.text = "prepaid_card_title".localized
        pickamountlbl.text = "or_pick_qucik_amount".localized
        pageTitlelbl.text = "enter_your_amount".localized
        btnMyCards.setTitle("my_card".localized, for: .normal)
        btnLoadCard.setTitle("load_card".localized, for: .normal)

        cardTableView.delegate = self
        cardTableView.dataSource = self
        
        txtAmount.setLeftPaddingPoints(10)
        txtAmount.layer.cornerRadius = 8
        generateLoadCardBtn.layer.cornerRadius = 8
        btn100.layer.cornerRadius = btn100.frame.height/2
        btn200.layer.cornerRadius = btn200.frame.height/2
        btn300.layer.cornerRadius = btn300.frame.height/2
        btn400.layer.cornerRadius = btn400.frame.height/2
        btn500.layer.cornerRadius = btn500.frame.height/2
        
        btn100.layer.borderWidth = 0.6
        btn200.layer.borderWidth = 0.6
        btn300.layer.borderWidth = 0.6
        btn400.layer.borderWidth = 0.6
        btn500.layer.borderWidth = 0.6
        
        btn100.layer.borderColor = UIColor.black.cgColor
        btn200.layer.borderColor = UIColor.black.cgColor
        btn300.layer.borderColor = UIColor.black.cgColor
        btn400.layer.borderColor = UIColor.black.cgColor
        btn500.layer.borderColor = UIColor.black.cgColor
        
        getCustomerCard()
    }
    
    @IBAction func btnQuickAmountFunc(_ sender: UIButton) {
        btn100.layer.borderColor = UIColor.black.cgColor
        btn200.layer.borderColor = UIColor.black.cgColor
        btn300.layer.borderColor = UIColor.black.cgColor
        btn400.layer.borderColor = UIColor.black.cgColor
        btn500.layer.borderColor = UIColor.black.cgColor
        
        sender.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        txtAmount.text = sender.titleLabel?.text
        
    }
    
    
    @IBAction func btnGenerateLoadCardCick(_ sender: UIButton) {
        if customerCardNo.isEmpty  {
            generateCustomerCardNo()
        } else if sender.titleLabel!.text == "load_card".localized {
            if isValidate() {
                loadPrepaidCard()
            }
        }
    }
    
    
    @IBAction func btnMyCards(_ sender: UIButton) {
        
        loadViewb.isHidden = true
        viewBar.isHidden = false
        self.cardTableView.isHidden = false
        self.viewLoadCard.isHidden = true
        self.generateLoadCardBtn.setTitle("generate_prepaid_card".localized, for: .normal)
        if customerCardNo.isEmpty {
            self.generateLoadCardBtn.isHidden = false
        } else {
            self.generateLoadCardBtn.isHidden = true
        }
       
        
//        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
//            self.viewBar.frame = CGRect(x: self.btnMyCards.frame.origin.x , y: self.viewBar.frame.origin.y, width: self.viewBar.frame.size.width ,height: 2)
//
//            self.cardTableView.isHidden = false
//            self.viewLoadCard.isHidden = true
//            self.generateLoadCardBtn.setTitle("generate_prepaid_card".localized, for: .normal)
//            self.generateLoadCardBtn.isHidden = false
//        }, completion: { (finished: Bool) -> Void in
//
//        })
    }
    
    @IBAction func btnLoadCardFunc(_ sender: UIButton) {
        loadViewb.isHidden = false
        viewBar.isHidden = true
        self.cardTableView.isHidden = true
        self.viewLoadCard.isHidden = false
        self.generateLoadCardBtn.setTitle("load_card".localized, for: .normal)
        self.generateLoadCardBtn.isHidden = false
//        
//        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
//            self.viewBar.frame = CGRect(x: self.btnLoadCard.frame.origin.x , y: self.viewBar.frame.origin.y, width: self.viewBar.frame.size.width ,height: 2)
//            
//            self.cardTableView.isHidden = true
//            self.viewLoadCard.isHidden = false
//            self.generateLoadCardBtn.setTitle("load_card".localized, for: .normal)
//            self.generateLoadCardBtn.isHidden = false
//        }, completion: { (finished: Bool) -> Void in
//            
//        })
    }
    
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK : TableView Functions
extension PrepardCardVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableCell") as! CardTableCell
        cell.viewMain.layer.cornerRadius = 8
        cell.lblCardTitle.text = preferenceHelper.getCustomerName()
        cell.lblCardNumber.text = customerCardNo.separate(every: 4, with: "-")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
    
    func loadPrepaidCard() {
        if preferenceHelper.getISKYCApproved() {
            if Network.isConnectedToNetwork() {
                 showProgress()
                let request = LoadVirtualCardRequest()
                request.customerNo = preferenceHelper.getCustomerNo()
                request.languageID = preferenceHelper.getApiLangugae()
                request.virtualCardNo = customerCardNo
                request.loadAmount = txtAmount.text!
                
                
                repo.loadVirtualCard(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_LOAD_VIRTUAL_CARD), completion: {(response , error ) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.showSuccess(message: response!.description!)
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                self.noInternet()
            }
        } else {
            self.showError(message: "plz_complete_kyc".localized)
        }
    }
    
    
    
    func generateCustomerCardNo() {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = AddCustomerCardNoRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.languageID = preferenceHelper.getApiLangugae()
            
            repo.createCustomerCardNo(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_ADD_CUSTOMER_CARD_NO), completion: {(response , error ) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.customerCardNo = response!.cardNo
                    self.cardTableView.reloadData()
                    
                    self.generateLoadCardBtn.isHidden = true
                } else {
                    self.showError(message: response!.description!)
                }
            })
        }
    }
    
    
    func getCustomerCard() {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = GetCustomerCardNoRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.languageID = preferenceHelper.getApiLangugae()
            
            
            repo.getCustomerCardNo(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CUSTOMER_CARD_NO), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.customerCardNo =  response!.cardNo
                    self.cardTableView.reloadData()
                    self.generateLoadCardBtn.isHidden = true
                }
//                else if response!.cardNo.isEmpty {
//                    self.generateLoadCardBtn.isHidden = false
//                    self.generateLoadCardBtn.setTitle("Generate Card", for: .normal)
//                }
                else {
                    self.showError(message: response!.description!)
                }
            })
        } else {
            self.noInternet()
        }
    }
  
}
