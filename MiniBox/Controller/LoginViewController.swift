//
//  LoginViewController.swift
//  MiniBox
//
//  Created by kevin on 10/01/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import Alamofire

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var moneyboxManager = MoneyboxDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
    }
    
// Sign in and error code handling
    @IBAction func logInPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        moneyboxManager.getUserDetails {
            self.spinner.hidesWhenStopped = true
            self.spinner.stopAnimating()
            if let email = self.emailTextField.text , let password = self.passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    switch error {
                    case .some(let error as NSError) where error.code == AuthErrorCode.userNotFound.rawValue:
                        self.errorTextField.text = "User not found"
                    case .some(let error as NSError) where error.code == AuthErrorCode.wrongPassword.rawValue:
                        self.errorTextField.text = "Wrong Password"
                    case .some(let error as NSError) where error.code == AuthErrorCode.invalidEmail.rawValue:
                        self.errorTextField.text = "The email address you entered is not valid"
                    case .none:
                        self.performSegue(withIdentifier: "logInToAccount", sender: nil)
                    case .some(_):
                        print("unknown error")
                    }
                }
            }
        }
    }
}
