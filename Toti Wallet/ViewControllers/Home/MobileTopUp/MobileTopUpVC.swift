//
//  MobileTopUpVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 02/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MobileTopUpVC: BaseVC , WRCountryListProtocol , WRBillerNameProtocol {
    
    
    let repo:UtilityRepository = UtilityRepository()
    
    @IBOutlet weak var btnType: UIButton!
    
    @IBOutlet weak var btnOperator: UIButton!
    @IBOutlet weak var btnChoosePlan: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var flagIcon: UIImageView!
    @IBOutlet weak var countryView: UIView!
    
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var codelbl: UILabel!
    @IBOutlet weak var opertaorStack: UIStackView!
    
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var countrylbl: UILabel!
    
    @IBOutlet weak var operatorlbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    
    var countryShortName = ""
    var operatorLoaded = false
    
    func isNumberValidate() -> Bool {
        if countryShortName.isEmpty {
            showError(message: "select_country".localized)
            return false
        }else if txtPhoneNumber.text!.isEmpty {
            showError(message: "plz_enter_mobile_no".localized)
            return false
        } else if !verifyNumber(number: codelbl.text! + txtPhoneNumber.text!) {
            showError(message: "invalid_number".localized)
            return false
        }
        return true
    }
    
    
    override func isValidate() -> Bool {
        if countryShortName.isEmpty {
            showError(message: "select_country".localized)
            return false
        }else if txtPhoneNumber.text!.isEmpty {
            showError(message: "plz_enter_mobile_no".localized)
            return false
        } else if !verifyNumber(number: codelbl.text! + txtPhoneNumber.text!) {
            showError(message: "invalid_number".localized)
            return false
        }
       
        else if !operatorLoaded {
            showError(message: "select_operator".localized)
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolTitle.text = "mobile_top_up".localized
        pageTitle.text = "mobile_top_up".localized
        countrylbl.text = "mobile_number".localized
        typelbl.text = "select_type".localized
        operatorlbl.text = "select_operator".localized
        btnNext.setTitle("next".localized, for: .normal)
        
        txtPhoneNumber.placeholder = "phone_number_hint".localized
        btnType.setTitle("select_type".localized, for: .normal)
        btnOperator.setTitle("select_operator".localized, for: .normal)
        
        btnType.layer.cornerRadius = 8
        countryView.layer.cornerRadius = 8
        btnOperator.layer.cornerRadius = 8
        btnChoosePlan.layer.cornerRadius = 8
        txtPhoneNumber.setLeftPaddingPoints(5)
        
        btnType.imageEdgeInsets.left = self.view.frame.width - 50
        
        btnOperator.imageEdgeInsets.left = self.view.frame.width - 50
        flagIcon.makeImageCircle()
        
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
        
    }
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.wrCountryVC.instance
        (nextVC as! WrCountryVC).delegate = self
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
    @IBAction func btnOnTopupType(_ sender: Any) {
        if isNumberValidate() {
            let nextVC = ControllerID.simTypeVC.instance
            (nextVC as! SimTypeVC).delegate = self
            (nextVC as! SimTypeVC).countryCode = countryShortName
            self.pushWithFullScreen(nextVC)
        }
        
    }
    
    
    @IBAction func btnOnNextClick(_ sender:Any) {
        if isValidate() {
            let nextVC = ControllerID.selectPlanVC.instance
            self.pushWithFullScreen(nextVC)
        }
   
    }
    
    
    @IBAction func btnOnOperator(_ sender: Any) {
        
    }
    
    func onSelectCountry(country: WRCountry) {
        countryShortName  = country.countryShortName
        codelbl.text = country.countryCode
        flagIcon.sd_setImage(with: URL(string: country.image_URL), placeholderImage: UIImage(named: "flag"))
        flagIcon.makeImageCircle()
        
        
        WRPrepaidRechargeRequest.shared.payoutCurrency = country.countryCurrency
        WRPrepaidRechargeRequest.shared.countryCode = country.countryShortName
    }
    
    
    func onSelectBillerType(biller: WRBillerType) {
        btnType.setTitle(biller.billerName, for: .normal)
        btnType.setTitleColor(.black, for: .normal)
        getPrepaidOperator()
    }
    
    
    func getPrepaidOperator() {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = GetWRPrepaidOperatorRequest()
            request.countryShortName = countryShortName;
            request.mobileNo = txtPhoneNumber.text!
            request.languageId = preferenceHelper.getLanguage()
            
            repo.getPrepaidOperators(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.GET_WR_PREPAID_OPERATOR_ACTION), completion: {(response , error ) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.showOperator(pOperator: response!)
                } else {
                    self.showError(message: response!.description!)
                }
            })
            
        } else {
            self.noInternet()
        }
    }
    
    
    func showOperator(pOperator:PrepaidOperatorResponse) {
        btnOperator.setTitle(pOperator.operatorName , for: .normal)
        btnOperator.setTitleColor(.black, for: .normal)
        operatorLoaded = true
        GetWRPrepaidPlansRequest.shared.circleCode = pOperator.circleCode
        GetWRPrepaidPlansRequest.shared.countryCode = countryShortName
        GetWRPrepaidPlansRequest.shared.operatorCode = pOperator.operatorCode!
        GetWRPrepaidPlansRequest.shared.languageId = preferenceHelper.getLanguage()
        
        opertaorStack.isHidden = false
        WRPrepaidRechargeRequest.shared.operatorName = pOperator.operatorName!
        WRPrepaidRechargeRequest.shared.mobileNumber = txtPhoneNumber.text!
    }
}
