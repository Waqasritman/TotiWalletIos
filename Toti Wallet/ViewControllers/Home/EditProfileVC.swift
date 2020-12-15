//
//  EditProfileVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 14/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class EditProfileVC: BaseVC {
    var customerProfile = GetCustomerProfileResponse()
    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnDOB: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtResidenceCountry: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var imgOutlet: UIImageView!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgOutlet.layer.cornerRadius = imgOutlet.frame.height/2
        txtFirstName.layer.cornerRadius = 8
        txtLastName.layer.cornerRadius = 8
        txtNumber.layer.cornerRadius = 8
        txtEmail.layer.cornerRadius = 8
        btnDOB.layer.cornerRadius = 8
        txtAddress.layer.cornerRadius = 8
        txtResidenceCountry.layer.cornerRadius = 8
        btnUpdate.layer.cornerRadius = 8
        
        btnDOB.imageEdgeInsets.left = self.view.frame.width - 60
        txtFirstName.setLeftPaddingPoints(10)
        txtLastName.setLeftPaddingPoints(10)
        txtNumber.setLeftPaddingPoints(10)
        
        txtEmail.setLeftPaddingPoints(10)
        txtAddress.setLeftPaddingPoints(10)
        txtResidenceCountry.setLeftPaddingPoints(10)
        
        
        getCustomerProfile()
        disableViews()
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnUpdateProfile(_ sender:UIButton) {
        
        let editCustomerProfileRequest:EditCustomerProfileRequest = EditCustomerProfileRequest()
        editCustomerProfileRequest.customer.firstName = customerProfile.firstName
        editCustomerProfileRequest.customer.lastName = customerProfile.lastName
        editCustomerProfileRequest.customer.middleName = customerProfile.middleName
        editCustomerProfileRequest.customer.nationality = customerProfile.nationality
        editCustomerProfileRequest.customer.email = customerProfile.email
        editCustomerProfileRequest.customer.phoneNumber = customerProfile.mobileNo
        editCustomerProfileRequest.customer.gender = customerProfile.gender
        editCustomerProfileRequest.idType = Int(customerProfile.idType)
        editCustomerProfileRequest.customer.dob = customerProfile.dateOfBirth
        editCustomerProfileRequest.idExpireDate = customerProfile.idExpireDate
        editCustomerProfileRequest.idIssueDate = customerProfile.idIssueDate
        editCustomerProfileRequest.idNumber = customerProfile.idNumber
        editCustomerProfileRequest.customerNo = preferenceHelper.getCustomerNo()
        editCustomerProfileRequest.residenceCountry = customerProfile.residenceCountry
        editCustomerProfileRequest.customer.address = txtAddress.text!
        editCustomerProfileRequest.languageId = preferenceHelper.getLanguage()
        print(editCustomerProfileRequest.getXML())
        
        if Network.isConnectedToNetwork() {
            showProgress()
            authRepo.editCustomerProfile(request: HTTPConnection.openConnection(stringParams: editCustomerProfileRequest.getXML(), action: SoapActionHelper.shared.ACTION_EDIT_PROFILE), completion: {(response , error) in
                self.hideProgress()
                if let error = error  {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.showSuccess(message: response!.description)
                } else {
                    self.showError(message: response!.description!)
                }
            })
            
        } else {
            self.noInternet()
        }
        
        
    }
    
    func disableViews() {
        txtFirstName.isEnabled = false
        txtLastName.isEnabled = false
        txtNumber.isEnabled = false
        txtEmail.isEnabled = false
        btnDOB.isEnabled = false
        txtResidenceCountry.isEnabled = false
        txtAddress.isEnabled = true
    }
    
    func getCustomerProfile() {
        if Network.isConnectedToNetwork() {
            let request = GetCustomerProfileRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.emailAddress = ""
            request.mobileNo = ""
            request.languageId = "1"
            
            
            authRepo.getCustomerProfile(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CUSTOMER), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else  if response!.responseCode == 101 {
                    self.customerProfile = response!
                    self.showProfile(customer: response!)
                }
                else {
                    self.showError(message: response!.description!)
                }
            })
            
            
        } else {
            self.noInternet()
        }
    }
    
    
    func showProfile(customer:GetCustomerProfileResponse){
        txtFirstName.text = customer.firstName
        txtLastName.text = customer.lastName
        txtNumber.text = customer.mobileNo
        txtEmail.text = customer.email
        btnDOB.setTitle(customer.dateOfBirth, for: .normal)
        btnDOB.setTitleColor(.black, for: .normal)
        txtResidenceCountry.text = customer.residenceCountry
        txtAddress.text = customer.address
    }
    
}
