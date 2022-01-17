//
//  MiniboxModel.swift
//  MiniBox
//
//  Created by kevin on 10/01/2022.
//

import Foundation

struct UserDataModel: Codable {
    
    let user: UserModel
    let session: SessionModel
    
    private enum CodingKeys: String, CodingKey {
        case user = "User",
             session = "Session"
    }
    
}

struct UserModel: Codable {
    
    let firstName: String
    let lastName: String

    private enum CodingKeys: String, CodingKey {
        case firstName = "FirstName",
             lastName = "LastName"
    }
    
}

struct SessionModel: Codable {
    let bearerToken: String
    
    private enum CodingKeys: String, CodingKey {
        case bearerToken = "BearerToken"
    }
}



struct InvestorProductsModel: Codable {
    let totalPlanValue: Float
    let products: [ProductModel]
    
    private enum CodingKeys : String, CodingKey {
        case totalPlanValue = "TotalPlanValue",
             products = "ProductResponses"
    }
}

struct ProductModel: Codable {
    let id: Int
    let planValue: Float
    let moneybox: Float
    let product: ProductName
    
    private enum CodingKeys : String, CodingKey {
        case id = "Id",
             planValue = "PlanValue",
             moneybox = "Moneybox",
             product = "Product"
    }
}

struct ProductName: Codable {
    let friendlyName: String
    
    private enum CodingKeys : String, CodingKey {
        case friendlyName = "FriendlyName"
    }
}
