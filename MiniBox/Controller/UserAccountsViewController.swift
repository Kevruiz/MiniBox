//
//  UserAccountsViewController.swift
//  MiniBox
//
//  Created by kevin on 10/01/2022.
//

import UIKit
import Alamofire
import KeychainAccess

class UserAccountViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var moneyboxManager = MoneyboxDataManager()
    var firstName = keychain["firstName"]
    var lastName = keychain["lastName"]
    var totalPlan: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        setup()

        self.name.text = "Hello \(firstName!) \(lastName!)"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AccountsTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountsCell")
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    //runs API call to get users account details and displays them to the table view
    func setup() {
        moneyboxManager.accountDetails {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

//populating tableview cells with decoded JSON data from API call
extension UserAccountViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
        self.performSegue(withIdentifier: "AccountDetails", sender: nil)
    }
}

extension UserAccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountsCell", for: indexPath) as! AccountsTableViewCell
        
        if (account?.products.count)! > indexPath.row {
            let name = account?.products[indexPath.row].product.friendlyName
            let value = account?.products[indexPath.row].planValue
            let box = account?.products[indexPath.row].moneybox
            
            cell.accountName?.text = name
            cell.planValue?.text = "Plan Value: £\(String(describing: value!))"
            cell.moneyBox?.text = "Moneybox: £\(String(describing: box!))"
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return account?.products.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AccountDetails" ,
            let nextScene = segue.destination as? AccountDetailsViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            nextScene.indexNumber = indexPath.row
        }
    }
}
