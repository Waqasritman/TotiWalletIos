//
//  SoapActionHelper.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class SoapActionHelper {
      static var shared = SoapActionHelper()
    
      let ACTION_LOAD_WALLET = "TPay/ITotiPay/LoadWallet";
      let ACTION_DELETE_BENEFICIARY = "TPay/ITotiPay/deleteBeneficiary";
      let ACTION_GET_ID = "TPay/ITotiPay/GetIDType";
      let ACTION_CAL_TRANSFER = "TPay/ITotiPay/CalTransfer";
      let ACTION_GET_BENEFICIARY_LIST = "TPay/ITotiPay/GetBeneficiaryList";
      let ACTION_SEND_TRANSFER = "TPay/ITotiPay/TotiPaySend";
      let ACTION_GET_CASH_NETWORK_LIST = "TPay/ITotiPay/GetCashNetworkList";
      let ACTION_GetPurposeOfTransferResult = "TPay/ITotiPay/GetPurposeOfTransferList";
      let ACTION_GET_COUNTRY_LIST = "TPay/ITotiPay/GetCountryList";
      let ACTION_GET_RELATION_SHIP_LIST = "TPay/ITotiPay/GetRelationList";
      let ACTION_GET_SOURCE_OF_INCOME = "TPay/ITotiPay/GetSourceOfIncomeList";
      let ACTION_GET_LOGIN = "TPay/ITotiPay/Login";
      let ACTION_GET_BANK_NETWORK_LIST = "TPay/ITotiPay/GetBankNetworkList";
      let ACTION_APP_SETTINGS = "TPay/ITotiPay/AppSetting";
      let ACTION_ADD_BENEFICIARY = "TPay/ITotiPay/BeneficiaryRegistration";
      let ACTION_CREATE_WALLET = "TPay/ITotiPay/CreateWallet";
    //GetCCYForWallet
      let ACTION_BANK_DEPOSIT_DETAILS  = "TPay/ITotiPay/GetTotiPayAccDetails"
      let ACTION_ADD_CCY_WALLET = "TPay/ITotiPay/GetCCYForWallet";
      let ACTION_PAY_OUT_CURRENCY = "TPay/ITotiPay/APIGetPayOutCurrencyList";
      let ACTION_CUSTOMER_REGISTRATION = "TPay/ITotiPay/CustomerRegistration";
      let ACTION_AUTHENTICATION = "TPay/ITotiPay/Authentication";
      let ACTION_GET_REC_CURRENCY = "TPay/ITotiPay/GetSendRecCurrency";
      let ACTION_GET_WALLET_CURRENCY = "TPay/ITotiPay/GetWalletCurrencyList";
      let ACTION_GET_CUSTOMER_WALLET = "TPay/ITotiPay/GetCustWalletDetails";
      let ACTION_EDIT_PROFILE = "TPay/ITotiPay/EditCustomerProfile";
      let ACTION_HISTORY = "TPay/ITotiPay/TransactionHistory";
      let ACTION_GET_TRANSACTION_RECEIPT = "TPay/ITotiPay/GetTransactionReceipt";
      let ACTION_GET_CUSTOMER = "TPay/ITotiPay/GetCustomerProfile";
      let ACTION_VERIFY_OTP = "TPay/ITotiPay/VerifyOTP";
      let ACTION_CHANGE_PIN = "TPay/ITotiPay/ChangePIN";
      let ACTION_SET_NEW_PIN = "TPay/ITotiPay/SetNewPIN";
      let ACTION_FORGOT_REQUEST_APPROVED_USER = "TPay/ITotiPay/ForgetPIN";
      let ACTION_WALLET_TO_WALLET = "TPay/ITotiPay/WalletToWalletTransfer";
      let ACTION_WALLET_BALANCE = "TPay/ITotiPay/WalletBalance";
      let ACTION_UPLOAD_IMAGE = "TPay/ITotiPay/UploadKYCImage";
      let ACTION_WALLET_HISTORY = "TPay/ITotiPay/WalletTransactionHistory";
      let ACTION_REQUEST_MONEY = "TPay/ITotiPay/RequestMoney";
      let ACTION_GET_BANK_NAME = "TPay/ITotiPay/BankNameList";
      let ACTION_EDIT_BENEFICIARY = "TPay/ITotiPay/EditBeneficiaryProfile";
      let ACTION_B2B_BENEFICIARY = "TPay/ITotiPay/B2BTransferDetails";
      let ACTION_GET_WR_BILLER_CATEGORY = "TPay/ITotiPay/GetWRBillerCategory";
      let ACTION_GET_WR_COUNTRY = "TPay/ITotiPay/GetWRCountryList";
      let ACTION_GET_WR_BILLER_TYPE = "TPay/ITotiPay/GetWRBillerType";
      let ACTION_GET_WR_BILLER_TYPE_MOBILE = "TPay/ITotiPay/GetWRBillerTypeMobileTopUp";
      let ACTION_WR_BILLER_NAMES = "TPay/ITotiPay/GetWRBillerNames";
      let ACTION_WR_BILLER_PLAN = "TPay/ITotiPay/GetWRBillerPlan";
      let ACTION_WR_PAY_BILL = "TPay/ITotiPay/WRPayBill";
      let ACTION_GET_CARD_DETAILS = "TPay/ITotiPay/GetCardDetails";
      let ACTION_SAVE_CARD_DETAILS = "TPay/ITotiPay/SaveCardDetails";
      let ACTION_BILL_DETAILS = "TPay/ITotiPay/WRBillDetail";
      let ACTION_ADD_CUSTOMER_CARD_NO = "TPay/ITotiPay/AddCustomerCardNO";
      let ACTION_GET_CUSTOMER_CARD_NO = "TPay/ITotiPay/GetCustomerCardNO";
      let ACTION_MATCH_PIN = "TPay/ITotiPay/MatchPIN";
      let ACTION_WR_BILLER_FIELDS = "TPay/ITotiPay/GetWRBillerFields";
      let ACTION_Y_CITY_ACTION = "TPay/ITotiPay/GetYCity";
      let ACTION_Y_LOCATION_ACTION = "TPay/ITotiPay/GetYLocation";
      let ACTION_Y_BRANCH_ACTION = "TPay/ITotiPay/GetYBranches";
      let ACTION_LOAD_VIRTUAL_CARD = "TPay/ITotiPay/LoadVirtualCard";
      let GET_WR_PREPAID_OPERATOR_ACTION = "TPay/ITotiPay/GetWRPrepaidOperator";
      let ACTION_GET_PREPAID_PLAN = "TPay/ITotiPay/GetWRPrepaidPlans";
      let ACTION_WR_PERPAID_RECHARGE = "TPay/ITotiPay/WRPrepaidRecharge";
      let ACTION_PREPAID_STATUS = "TPay/ITotiPay/WRPrepaidStatus";
}
