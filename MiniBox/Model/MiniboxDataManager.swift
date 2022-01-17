//
//  MiniboxDataManager.swift
//  MiniBox
//
//  Created by kevin on 10/01/2022.
//

import Foundation
import Alamofire
import KeychainAccess
import UIKit

var account: InvestorProductsModel?

private let login = Login(email: "test+ios@moneyboxapp.com", password: "P455word12")

private var headers: HTTPHeaders = [

    "AppId": "8cb2237d0679ca88db6464",
    "Content-Type": "application/json",
    "appVersion": "7.10.0",
    "apiVersion": "3.0.0"
    ]

struct MoneyboxDataManager {
    // getting user details and token using Alamofire .post request
    func getUserDetails(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            AF.request("\(url)/users/login",
                       method: .post,
                       parameters: login,
                       encoder: JSONParameterEncoder.default,
                       headers: headers).responseDecodable(of:UserDataModel.self) {
                response in
                let token = (response.value?.session.bearerToken)!
                let firstName = (response.value?.user.firstName)!
                let lastName = (response.value?.user.lastName)!
                keychain["token"] = String (token)
                keychain["firstName"] = String (firstName)
                keychain["lastName"] = String (lastName)
                debugPrint(token)
                debugPrint(response)
                completion()
            }
        }
    }
    
    //AlamoFire .post request to add £10 to users moneybox account
    func addTen(parameters: [String: Int?], completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            headers["Authorization"] = "Bearer \(keychain["token"]!)"
            AF.request("\(url)/oneoffpayments",
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default,
                       headers: headers).response {
                response in
                debugPrint(response)
                completion()
            }
        }
    }
    
    //fetching user account details from API and parsing it using JSONDecoder
    func accountDetails(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            headers["Authorization"] = "Bearer \(keychain["token"]!)"
            AF.request("\(url)/investorproducts",
                       method: .get,
                       encoding: JSONEncoding.default,
                       headers: headers).responseJSON { response in
                guard let data = response.data else { return }
                do {
                    account = try JSONDecoder().decode(InvestorProductsModel.self, from: data)
                    debugPrint(account)
                    print(account?.products.count)
                    completion()
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        }
    }
}
