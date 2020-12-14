//
//  CashBeneficiaryBranchVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CashBeneficiaryBranchVC: BaseVC , YCityProtocol , YLocationProtocol , YBranchesProtocol {
   
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnBranch: UIButton!
    @IBOutlet weak var btnAddBeneficary: UIButton!
    @IBOutlet weak var stackBranch: UIStackView!
    
    var isCitySelected = false
    var isLocationSelected = false
    var isBranchSelected = false
    
    
    var cityId:Int!
    var locationId:Int!
    
    let repo = BeneficiaryRespository()
    var yCities:[YCities] = Array()
    var yLocations:[YLocations] = Array()
    var yBranches:[YBranches] = Array()
    
    override func isValidate() -> Bool {
        if !isCitySelected {
            return false
        } else if !isLocationSelected {
            return false
        } else if !isBranchSelected {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCity.layer.cornerRadius = 8
        btnLocation.layer.cornerRadius = 8
        btnBranch.layer.cornerRadius = 8
        btnAddBeneficary.layer.cornerRadius = 8
        
        stackBranch.isHidden = true
    }
    
    
    
    @IBAction func btnCity(_ sender:Any) {
        if yCities.isEmpty {
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = GetYCityRequest()
                request.languageId = preferenceHelper.getLanguage()
                repo.getYCities(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_Y_CITY_ACTION), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.yCities.removeAll()
                        self.yCities.append(contentsOf: response!.list)
                        self.showCity()
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                self.noInternet()
            }
        } else {
            showCity()
        }
    }
    
   
    @IBAction func btnLocation(_ sender:Any) {
        if yLocations.isEmpty {
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = GetYLocationRequest()
                request.cityID = cityId
                request.languageID = preferenceHelper.getLanguage()
                repo.getYLocations(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_Y_LOCATION_ACTION), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.yLocations.removeAll()
                        self.yLocations.append(contentsOf: response!.list)
                        self.showLocation()
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                self.noInternet()
            }
        } else {
            showLocation()
        }
    }
    
    @IBAction func btnBranch(_ sender:Any) {
        if yBranches.isEmpty {
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = GetYBranchRequest()
                request.cityID = cityId
                request.locationID = locationId
                request.languageID = preferenceHelper.getLanguage()
                repo.getYBranch(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_Y_BRANCH_ACTION), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.yBranches.removeAll()
                        self.yBranches.append(contentsOf: response!.list)
                        self.showBranch()
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                self.noInternet()
            }
        } else {
            showBranch()
        }
    }
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                showProgress()
                print(BeneficiaryAddRequest.shared.getXML())
                repo.addBeneficiary(request: HTTPConnection.openConnection(stringParams: BeneficiaryAddRequest.shared.getXML(), action: SoapActionHelper.shared.ACTION_ADD_BENEFICIARY), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.showSuccess(message: response!.description!)
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            }
        }
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        if let destinationViewController = navigationController?.viewControllers
            .filter(
                {$0 is CustomTabBarController})
            .first {
            navigationController?.popToViewController(destinationViewController, animated: true)
        }
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    func onSelectYCity(city: YCities) {
        btnCity.setTitle(city.cityName, for: .normal)
        cityId = city.cityId
        isCitySelected = true
    }
    
    func onSelectLocation(location: YLocations) {
        btnLocation.setTitle(location.locationName, for: .normal)
        locationId = location.locationId
        stackBranch.isHidden = false
        isLocationSelected = true
    }
    
    func onSelectBranch(branch: YBranches) {
        btnBranch.setTitle(branch.branchName, for: .normal)
        BeneficiaryAddRequest.shared.PaymentMode = PaymentMode.payment_cash
        BeneficiaryAddRequest.shared.PayOutBranchCode = String(branch.branchID)
        isBranchSelected = true
    }
    
    
    func showCity(){
        let nextVc = ControllerID.ycities.instance
        (nextVc as! YCitiesVC).delegate = self
        (nextVc as! YCitiesVC).filteredList = yCities
        self.pushWithFullScreen(nextVc)
    }
    
    func showLocation(){
        let nextVc = ControllerID.yLocations.instance
        (nextVc as! YLocationsVC).delegate = self
        (nextVc as! YLocationsVC).filteredList = yLocations
        self.pushWithFullScreen(nextVc)
    }
    
    func showBranch(){
        let nextVc = ControllerID.yBranches.instance
        (nextVc as! YBranchesVC).delegate = self
        (nextVc as! YBranchesVC).filteredList = yBranches
        self.pushWithFullScreen(nextVc)
    }
    
}
