//
//  FaqController.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/6/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import UIKit

class FaqController:  BaseVC , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    var sectionData:[Int: [String]] = [:]
    
    @IBOutlet weak var pageTitle:UILabel!
    
    let sections:[String] = ["faq_q1".localized , "faq_q2".localized
     ,"faq_q3".localized , "faq_q4".localized
     , "faq_q5".localized
     , "faq_q6".localized
    ,"faq_q7".localized, "faq_q8".localized
     , "faq_q9".localized , "faq_q10".localized
     , "faq_q11".localized
     , "faq_q12".localized, "faq_q13".localized]
    
    
    let a1:[String] = ["faq_ans_1".localized]
    let a2:[String] = ["faq_ans_2".localized]
    let a3:[String] = ["faq_ans_3".localized]
    let a4:[String] = ["faq_ans_4".localized]
    let a5:[String] = ["faq_ans_5".localized]
    let a6:[String] = ["faq_ans_6".localized]
    let a7:[String] = ["faq_ans_7".localized]
    let a8:[String] = ["faq_ans_8".localized]
    let a9:[String] = ["faq_ans_9".localized]
    let a10:[String] = ["faq_ans_10".localized]
    let a11:[String] = ["faq_ans_11".localized]
    let a12:[String] = ["faq_ans_12".localized]
    let a13:[String] = ["faq_ans_13".localized]
    


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        pageTitle.text = "FAQ".localized
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension;
        self.tableView.estimatedSectionHeaderHeight = 60;
        
        sectionData = [0 : a1 , 1 : a2 , 2 : a3 ,3 : a4 ,4 : a5 , 5 : a6 , 6 : a7 , 7 : a8 , 8 : a9 , 9 : a10 , 10 : a11 , 11 : a12 , 12 : a13 ]
    }
    
    
    @IBAction func onBack(_ sender:Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableCell(withIdentifier: "headerCell")! as! FaqHeaderCell
    
        sectionHeader.title.text = sections[section]
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionData[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            as! FaqDetailCell
    
        cell.answer.text = sectionData[indexPath.section]![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
class FaqHeaderCell:UITableViewCell {
    @IBOutlet weak var title:UILabel!
}


class FaqDetailCell: UITableViewCell {
    @IBOutlet weak var answer:UILabel!
}

