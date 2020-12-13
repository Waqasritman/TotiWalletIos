//
//  Storyboard.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

enum ControllerID<T: UIViewController> : String {
    
    case splashVC = "splashVC"
    case getStartedNav = "navStarted"
    case loginOptionVC = "LoginOptionVC"
    case loginVC = "LoginVC"
    case signUpVC = "SignUpVC"
    case verifyOptVC = "VerifyOptVC"
    case selectCountryVC = "SelectCountryVC"
    case forgotPassGetEmailVC = "ForgotPassGetEmailVC"
    case forgotPassGetPinVC = "ForgotPassGetPinVC"
    case forgotPassGetDataVC = "ForgotPassGetDataVC"
    case forgotPassotpVC = "ForgotPassotpVC"
    case profileBasicDetailVC = "ProfileBasicDetailVC"
    case profileAddressDetailVC = "ProfileAddressDetailVC"
    case tabbar = "tabbar"
    
    case quickPayVC = "QuickPayVC"
    case businessTranscationVC = "BusinessTranscationVC"
    case myQRCode = "MyQRCode"
    case settingsVC = "SettingsVC"
    case billPaymentVC = "BillPayment"
    case businessTextVC = "BusinessTextVC"
    case shareWthFriendVC = "ShareWthFriendVC"
    case loyaltyPointsVC = "LoyaltyPointsVC"
    case beneficiaryListVC = "BeneficiaryListVC"
    case notificationListVC = "NotificationListVC"
    case ourRatesVC = "OurRatesVC"
    case selectWalletVC = "SelectWalletVC"
    case mobileTopUpVC = "MobileTopUpVC"
    
    case changePinVC = "ChangePinVC"
    
    case walletTransferVC = "WalletTransferVC"
    case verifyTransferDetailVC = "VerifyTransferDetailVC"
    case verifyTransferPinVC = "VerifyTransferPinVC"
    case requestMoneyVC = "RequestMoneyVC"
    
    case selectCurrencyVC = "SelectCurrencyVC"
    
    case bankTransferConverterVC = "BankTransferConverterVC"
    case summaryVC = "SummaryVC"
    case paymentOptionVC = "PaymentOptionVC"
    case cardDetailVC = "CardDetailVC"
    case cashBeneficaryVC = "CashBeneficaryVC"
    case cashBeneficaryAddressVC = "CashBeneficaryAddressVC"
    case cashBeneficiaryBranchVC = "CashBeneficiaryBranchVC"
    
    
    case sourceOfIncome = "SourceOfIncomeVC"
    case purposeOfTransfer = "PurposeVC"
    case relationVC = "RelationVC"
    
    
    case ycities = "YCitiesVC"
    case yLocations = "YLocationsVC"
    case yBranches = "YBranchesVC"
    
    case transactionHistoryVC = "TransactionHistoryVC"
    case walletHistoryVC = "WalletHistoryVC"
    case receiptVC = "ReceiptVC"
    case repeatWalletVC = "RepeatWalletTransactionVC"
    case completeRegistrationVC = "CompleteRegistrationVC"
    case prepardCardVC = "PrepardCardVC"
    
    case addMoneyVC = "AddMoneyVC"
    case addMoneyPaymentOptionVC = "AddMoneyPaymentOptionVC"
    case addBankBeneficiaryVC = "AddBankBeneficiaryVC"
    case addBankBeneficiaryBankDetail = "AddBankBeneficiaryBankDetail"
    case idTypesVC = "IDTypeVC"
    
    case bankNamesVC = "BankNamesVC"
    case branchNamesVC = "BranchNamesVC"
    case indiaBankBeneVC = "BankBeneficiaryIndiaVC"
    
    case cardKyc = "CardPicVC"
    
    case simTypeVC = "SimTypeVC"
    case selectPlanVC = "SelectPlanVC"
    case mobileTopUpPaymentVC = "MobileTopUpPaymentVC"
    case mobileTopUpSuccessVC = "MobileTopUpSuccessVC"
    case beneficiaryDeleteVC = "BeneficiaryDeleteVC"
    case businessTransactionPaymentDetail = "BusinessTransactionPaymentDetail"
    case businessTransctionBankDetail = "BusinessTransctionBankDetail"
    case businessTransactionCorrespondent = "BusinessTransactionCorrespondent"
    
    var instance: T {
        return storyboard.instance(viewController: self.rawValue) as T
    }
    
    var storyboard: Storyboard {
        
        switch self {
        case .splashVC, .getStartedNav, .loginOptionVC, .loginVC, .signUpVC, .verifyOptVC, .selectCountryVC, .forgotPassGetEmailVC, .forgotPassGetPinVC, .forgotPassGetDataVC , .forgotPassotpVC :
            return .GetStarted
        case .profileBasicDetailVC, .profileAddressDetailVC:
            return .Profile
        case .tabbar, .notificationListVC, .ourRatesVC :
            return .Main
        case .myQRCode, .settingsVC, .billPaymentVC, .businessTextVC, .shareWthFriendVC, .loyaltyPointsVC, .beneficiaryListVC , .changePinVC:
            return .SideMenu
            
        case .quickPayVC,.sourceOfIncome,.purposeOfTransfer ,.walletTransferVC, .verifyTransferDetailVC, .verifyTransferPinVC, .requestMoneyVC, .bankTransferConverterVC, .summaryVC, .paymentOptionVC, .cardDetailVC, .cashBeneficaryVC, .cashBeneficaryAddressVC, .cashBeneficiaryBranchVC, .selectCurrencyVC , .relationVC , .ycities , .yLocations , .yBranches, .receiptVC, .prepardCardVC, .addBankBeneficiaryVC, .addBankBeneficiaryBankDetail ,.branchNamesVC , .bankNamesVC, .beneficiaryDeleteVC , .indiaBankBeneVC , .repeatWalletVC:
            return .MoneyTransfer
            
        case .transactionHistoryVC, .walletHistoryVC:
            return .History
        case .completeRegistrationVC , .idTypesVC , .cardKyc:
            return .KVC
        case .addMoneyVC, .selectWalletVC, .addMoneyPaymentOptionVC:
            return .AddMoney
        case .mobileTopUpVC, .simTypeVC, .selectPlanVC, .mobileTopUpPaymentVC, .mobileTopUpSuccessVC:
            return .MobileTopUp
        case .businessTranscationVC, .businessTransactionPaymentDetail, .businessTransctionBankDetail, .businessTransactionCorrespondent:
            return .BusinessTransction
        }
    }
    
}

enum Storyboard: String {
    case GetStarted
    case Profile
    case Main
    case SideMenu
    case MoneyTransfer
    case History
    case KVC
    case AddMoney
    case MobileTopUp
    case BusinessTransction
    
    func instance<T>(viewController: String) -> T {
        return self.refrence.instantiateViewController(withIdentifier: viewController) as! T
    }
    
    func instantiateViewController<T: UIViewController>(withViewClass: T.Type) -> T {
        return self.refrence.instantiateViewController(withIdentifier: String(describing: withViewClass.self)) as! T
    }
    
    var refrence: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}


extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(withViewClass: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: withViewClass.self)) as! T
    }
}

