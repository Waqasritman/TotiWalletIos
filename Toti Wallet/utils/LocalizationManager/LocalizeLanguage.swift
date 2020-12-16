
import UIKit

// constants

/// L102Language
class LocalizeLanguage
{
    /// get current Apple language
    class func currentLanguage() -> String
    {
        let languageIndex = Int(preferenceHelper.getLanguage())
        return arrForLanguages[languageIndex!].code
        
    }
    
    class func currentAppleLanguageFull() -> String
    {
        
        let languageIndex = Int(preferenceHelper.getLanguage())
        return arrForLanguages[languageIndex!].language
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLanguageTo(lang: Int)
    {
        preferenceHelper.setLanguage(String(lang))
    }

    class var isRTL: Bool
    {
        return LocalizeLanguage.currentLanguage() == "ar"
    }
}
