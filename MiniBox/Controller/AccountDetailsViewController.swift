//
//  AccountDetailsViewController.swift
//  MiniBox
//
//  Created by kevin on 10/01/2022.
//

import UIKit
import Alamofire
import KeychainAccess

class AccountDetailsViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var add10Btn: UIButton!
    @IBOutlet weak var moneybox: UILabel!
    
    var moneyboxManager = MoneyboxDataManager()
    var indexNumber: Int?
    var investorProductId:Int?

    var accountValue: Float?
    var accountMoneybox: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfo()
    }
    //setting up view with data
    func setupInfo() {
        accountValue = account?.products[indexNumber!].planValue
        accountMoneybox = account?.products[indexNumber!].moneybox
        investorProductId = account?.products[indexNumber!].id
        
        self.name.text = account?.products[self.indexNumber!].product.friendlyName
        self.value.text = "Plan Value: £\(String(describing: self.accountValue!))"
        self.moneybox.text = "Moneybox: £\(String(describing: self.accountMoneybox!))"
    }
    
    //when button is pressed adds £10 to moneybox account, then displays updated moneybox amount from loadData function
    @IBAction func addBtnPressed(_ sender: Any) {
        add10Btn.isEnabled = false
        let id = investorProductId!
        let parameters: [String: Int?] = [
            "Amount": 10,
            "InvestorProductId": id
        ]
        
        moneyboxManager.addTen(parameters: parameters) {
            DispatchQueue.main.async {
                //self.setupInfo()
                self.loadData()
            }
        }
    }
    
    //loads updated moneybox amount
    func loadData() {
        moneyboxManager.accountDetails {
            self.setupInfo()
            self.add10Btn.isEnabled = true
        }
    }
}
