//
//  PrepardCardVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class PrepardCardVC: UIViewController {

  
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var btnMyCards: UIButton!
    @IBOutlet weak var btnLoadCard: UIButton!
    @IBOutlet weak var viewLoadCard: UIView!
    @IBOutlet weak var btn100: UIButton!
    @IBOutlet weak var btn200: UIButton!
    @IBOutlet weak var btn300: UIButton!
    @IBOutlet weak var btn400: UIButton!
    @IBOutlet weak var btn500: UIButton!
    @IBOutlet weak var txtAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardTableView.delegate = self
        cardTableView.dataSource = self
        
        txtAmount.setLeftPaddingPoints(10)
        txtAmount.layer.cornerRadius = 8
        
        btn100.layer.cornerRadius = btn100.frame.height/2
        btn200.layer.cornerRadius = btn200.frame.height/2
        btn300.layer.cornerRadius = btn300.frame.height/2
        btn400.layer.cornerRadius = btn400.frame.height/2
        btn500.layer.cornerRadius = btn500.frame.height/2
        
        btn100.layer.borderWidth = 0.6
        btn200.layer.borderWidth = 0.6
        btn300.layer.borderWidth = 0.6
        btn400.layer.borderWidth = 0.6
        btn500.layer.borderWidth = 0.6
        
        btn100.layer.borderColor = UIColor.black.cgColor
        btn200.layer.borderColor = UIColor.black.cgColor
        btn300.layer.borderColor = UIColor.black.cgColor
        btn400.layer.borderColor = UIColor.black.cgColor
        btn500.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func btnQuickAmountFunc(_ sender: UIButton) {
        btn100.layer.borderColor = UIColor.black.cgColor
        btn200.layer.borderColor = UIColor.black.cgColor
        btn300.layer.borderColor = UIColor.black.cgColor
        btn400.layer.borderColor = UIColor.black.cgColor
        btn500.layer.borderColor = UIColor.black.cgColor
        
        sender.layer.borderColor = UIColor.red.cgColor
        txtAmount.text = sender.titleLabel?.text
        
    }
    
    @IBAction func btnMyCards(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.viewBar.frame = CGRect(x: self.btnMyCards.frame.origin.x , y: self.viewBar.frame.origin.y, width: self.viewBar.frame.size.width ,height: 2)
            
            self.cardTableView.isHidden = false
            self.viewLoadCard.isHidden = true
        }, completion: { (finished: Bool) -> Void in
            
        })
    }
    
    @IBAction func btnLoadCardFunc(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.viewBar.frame = CGRect(x: self.btnLoadCard.frame.origin.x , y: self.viewBar.frame.origin.y, width: self.viewBar.frame.size.width ,height: 2)
            
            self.cardTableView.isHidden = true
            self.viewLoadCard.isHidden = false
        }, completion: { (finished: Bool) -> Void in
            
        })
    }
    
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK : TableView Functions
extension PrepardCardVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableCell") as! CardTableCell
        cell.viewMain.layer.cornerRadius = 8
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
