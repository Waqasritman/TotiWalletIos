//
//  ExtensionString.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    
    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
    
    
    func removePlus(number:String) -> String {
        if !number.isEmpty {
            if number.prefix(1) == "+" {
                return String(number.dropFirst())
            } 
        }
        return number
    }
    
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func containsOnlyDigits() -> Bool
        {

            let notDigits = NSCharacterSet.decimalDigits.inverted

            if rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
            {
                return true
            }

            return false
        }
}

import UIKit

var creditCardFormatter : CreditCardFormatter
{
    return CreditCardFormatter.sharedInstance
}

class CreditCardFormatter : NSObject
{
    static let sharedInstance : CreditCardFormatter = CreditCardFormatter()

    func formatToCreditCardNumber(isAmex: Bool, textField : UITextField, withPreviousTextContent previousTextContent : String?, andPreviousCursorPosition previousCursorSelection : UITextRange?) {
        var selectedRangeStart = textField.endOfDocument
        if textField.selectedTextRange?.start != nil {
            selectedRangeStart = (textField.selectedTextRange?.start)!
        }
        if  let textFieldText = textField.text
        {
            var targetCursorPosition : UInt = UInt(textField.offset(from:textField.beginningOfDocument, to: selectedRangeStart))
            let cardNumberWithoutSpaces : String = removeNonDigitsFromString(string: textFieldText, andPreserveCursorPosition: &targetCursorPosition)
            if cardNumberWithoutSpaces.characters.count > 19
            {
                textField.text = previousTextContent
                textField.selectedTextRange = previousCursorSelection
                return
            }
            var cardNumberWithSpaces = ""
            if isAmex {
                cardNumberWithSpaces = insertSpacesInAmexFormat(string: cardNumberWithoutSpaces, andPreserveCursorPosition: &targetCursorPosition)
            }
            else
            {
                cardNumberWithSpaces = insertSpacesIntoEvery4DigitsIntoString(string: cardNumberWithoutSpaces, andPreserveCursorPosition: &targetCursorPosition)
            }
            textField.text = cardNumberWithSpaces
            if let finalCursorPosition = textField.position(from:textField.beginningOfDocument, offset: Int(targetCursorPosition))
            {
                textField.selectedTextRange = textField.textRange(from: finalCursorPosition, to: finalCursorPosition)
            }
        }
    }

    func removeNonDigitsFromString(string : String, andPreserveCursorPosition cursorPosition : inout UInt) -> String {
        var digitsOnlyString : String = ""
        for index in stride(from: 0, to: string.characters.count, by: 1)
        {
            let charToAdd : Character = Array(string.characters)[index]
            if isDigit(character: charToAdd)
            {
                digitsOnlyString.append(charToAdd)
            }
            else
            {
                if index < Int(cursorPosition)
                {
                    cursorPosition -= 1
                }
            }
        }
        return digitsOnlyString
    }

    private func isDigit(character : Character) -> Bool
    {
        return "\(character)".containsOnlyDigits()
    }

    func insertSpacesInAmexFormat(string : String, andPreserveCursorPosition cursorPosition : inout UInt) -> String {
        var stringWithAddedSpaces : String = ""
        for index in stride(from: 0, to: string.characters.count, by: 1)
        {
            if index == 4
            {
                stringWithAddedSpaces += "-"
                if index < Int(cursorPosition)
                {
                    cursorPosition += 1
                }
            }
            if index == 10 {
                stringWithAddedSpaces += "-"
                if index < Int(cursorPosition)
                {
                    cursorPosition += 1
                }
            }
            if index < 15 {
               let characterToAdd : Character = Array(string.characters)[index]
                stringWithAddedSpaces.append(characterToAdd)
            }
        }
        return stringWithAddedSpaces
    }


    func insertSpacesIntoEvery4DigitsIntoString(string : String, andPreserveCursorPosition cursorPosition : inout UInt) -> String {
        var stringWithAddedSpaces : String = ""
        for index in stride(from: 0, to: string.characters.count, by: 1)
        {
            if index != 0 && index % 4 == 0 && index < 16
            {
                stringWithAddedSpaces += "-"

                if index < Int(cursorPosition)
                {
                    cursorPosition += 1
                }
            }
            if index < 16 {
                let characterToAdd : Character = Array(string.characters)[index]
                stringWithAddedSpaces.append(characterToAdd)
            }
        }
        return stringWithAddedSpaces
    }

}
