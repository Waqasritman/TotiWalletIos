//
//  CalendarVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/9/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CalendarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func shwo() {
        let myDatePicker: UIDatePicker = UIDatePicker()
        // setting properties of the datePicker
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.frame = CGRect(x:4, y:40, width:260, height:200)
        myDatePicker.datePickerMode = UIDatePicker.Mode.date
        
        
        var components = DateComponents()
        components.year = -100
        let minDate = Calendar.current.date(byAdding: components, to: Date())
        
        components.year = -18
        let maxDate = Calendar.current.date(byAdding: components, to: Date())
        
        myDatePicker.minimumDate = minDate
        myDatePicker.maximumDate = maxDate
        
        let alertController = UIAlertController(title: "Select Date", message: "\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertController.Style.alert)
        
        alertController.view.addSubview(myDatePicker)
        let somethingAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:{(action:UIAlertAction!) in
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = DateFormatter.Style.short
            dateformatter.dateFormat = "dd/MM/yyyy"
            let now = dateformatter.string(from: myDatePicker.date)
//            self.btnDOB.setTitle(now, for: .normal)
//            self.btnAge.setTitle(myDatePicker.date.age, for: .normal)
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
        
    }

}
