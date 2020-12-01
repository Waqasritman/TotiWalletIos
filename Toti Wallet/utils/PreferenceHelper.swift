//
//  PreferenceHelper.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class PreferenceHelper :NSObject{
  
    
    let ph = UserDefaults.standard;
    static let preferenceHelper = PreferenceHelper()
    /*Check User Detail*/
       private let KEY_IS_APPROVED_KYC = "is_approve"
    private let KEY_IS_LOGIN_BY_EMAIL = "is_login_by_email"
    private let KEY_IS_LOGIN_BY_PHONE = "is_login_by_phone"

    // MARK: User Preference Keys
    private let KEY_FIRST_NAME = "first_name";
    private let KEY_LAST_NAME = "last_name";

    private let KEY_DOCUMENTED_UPLOADED = "is_docs_uploaded"
    private let KEY_ADDRESS = "address";
    private let KEY_PROFILE_PIC = "profile_pic";
    private let KEY_PHONE_NUMBER = "phone_number";
    private let KEY_PHONE_COUNTRY_CODE = "phone_country_code";
    private let KEY_COUNTRY_ID = "country_id";
    private let KEY_EMAIL = "email";

    /*Check User Detail*/

    private let KEY_IS_USER_DOCUMENT_UPLOADED = "is_user_document_uploaded";
    private let KEY_LANGUAGE = "language_id"
    
    
    func filCustomerData(userRequest:GetCustomerProfileResponse) {
          ph.set(userRequest.firstName, forKey:"first_name");
          ph.set(userRequest.lastName,forKey:"last_name");
          ph.set(userRequest.middleName,forKey: "middle_name");
          ph.set(userRequest.lastName, forKey:"last_name");
          ph.set(userRequest.address,forKey: "address");
          ph.set(userRequest.dateOfBirth, forKey:"dob");
          ph.set(userRequest.gender, forKey:"gender");
          ph.set(userRequest.mobileNo, forKey:"phone_number");
          ph.set(userRequest.nationality,forKey: "nationlaity");
          ph.set(userRequest.email,forKey: "emailID");
          ph.set(userRequest.residenceCountry, forKey:"residenceCountry");
          ph.set(userRequest.isApprovedKYC, forKey: KEY_IS_APPROVED_KYC)
        
          ph.synchronize()
      }
      
    
    func documentUploaded(value:Bool) {
        ph.set(value, forKey: KEY_DOCUMENTED_UPLOADED)
    }
    
    func getIsDocumentUploaded() -> Bool {
        return (ph.value(forKey: KEY_DOCUMENTED_UPLOADED) as? Bool) ?? false
    }
    
      func getISKYCApproved() -> Bool {
          return (ph.value(forKey: KEY_IS_APPROVED_KYC) as? Bool) ?? false
      }
      
      func setCustomerNo(customerNo:String) {
          ph.set(customerNo, forKey: "customer_no");
          ph.synchronize();
      }
      
      
      func getCustomerNo() -> String {
          return (ph.value(forKey: "customer_no") as? String) ?? ""
      }
      
      
      func setLanguage(_ index:Int)
      {
          ph.set(index, forKey: KEY_LANGUAGE);
          ph.synchronize();
      }
      func getLanguage() -> (String)
      {   return (ph.value(forKey: KEY_LANGUAGE) as? String) ?? "1"
      }
      
      
      func setProfilePicUrl(_ profileUrl:String)
      {
          ph.set(profileUrl, forKey: KEY_PROFILE_PIC);
          ph.synchronize();
      }
      func getProfilePicUrl() -> String
      {
          return (ph.value(forKey: KEY_PROFILE_PIC) as? String) ?? ""
      }
      
      
      func setEmail(_ email:String)
      {
          ph.set(email, forKey: KEY_EMAIL);
          ph.synchronize();
      }
      func getEmail() -> String
      {
          return (ph.value(forKey: KEY_EMAIL) as? String) ?? ""
      }
    
    
    func setCountryCode(code:String) {
        ph.set(code, forKey: "country_code")
        ph.synchronize()
    }
    
    func setNumber(number:String) {
        ph.set(number, forKey: "number")
        ph.synchronize()
    }
    
    func getCountryCode() -> String {
        return (ph.value(forKey: "country_code") as? String) ?? "+44"
    }
    
    func getNumber() -> String {
        return (ph.value(forKey: "number") as? String) ?? ""
    }
    
    func setURL(url:String) {
        ph.set(url, forKey: "url")
        ph.synchronize()
    }
    
    func getURL() -> String {
        return (ph.value(forKey: "url") as? String) ?? ""
    }
    
    func removeLoginDetails() {
        ph.set("", forKey: "number")
        ph.set("", forKey: "country_code")
        ph.set("", forKey: "url")
        ph.set("", forKey: KEY_EMAIL);
        ph.synchronize()
    }
      

    func clearAll()
    {
        ph.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        ph.synchronize();
    }
    
    
    func isWalletNeedToUpdate(isNeed:Bool) {
        ph.set(isNeed, forKey: "is_wallet_need_update")
        ph.synchronize()
    }
    
    func getIsWalletNeedToUpdate() -> Bool {
        return (ph.value(forKey: "is_wallet_need_update") as? Bool) ?? true
    }

}