//
//  JSONModel.swift
//  Redsoft. Initial contest.
//
//  Created by g01dt00th on 02.10.2020.
//

import Foundation

// MARK: - API Configuration
enum APIConfiguration: String {
    case urlString = "https://rstestapi.redsoftdigital.com/api/v1/"
    case productsString = "https://rstestapi.redsoftdigital.com/api/v1/products"
    case categoriesString = "https://rstestapi.redsoftdigital.com/api/v1/categories"
    case startFrom = "https://rstestapi.redsoftdigital.com/api/v1/products?startFrom="
    case filter = "https://rstestapi.redsoftdigital.com/api/v1/products?maxItems=10&sort=title&filter%5Btitle%5D="
}


struct JSONModel: Codable {
    let data: [Product]
}


struct Product: Codable, Identifiable, Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title, shortDescription: String
    let imageURL: String
    let amount: Int
    let price: Double
    let producer: String
    let categories: [Category]


    enum CodingKeys: String, CodingKey {
        case id, title
        case shortDescription = "short_description"
        case imageURL = "image_url"
        case amount, price, producer, categories
    }
}

struct Category: Codable, Identifiable, Hashable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let parentID: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case parentID = "parent_id"
    }
}

extension Double {
    func string(maximumFractionDigits: Int = 2) -> String {
        let s = String(format: "%.\(maximumFractionDigits)f", self)
        var offset = -maximumFractionDigits - 1
        for i in stride(from: 0, to: -maximumFractionDigits, by: -1) {
            if s[s.index(s.endIndex, offsetBy: i - 1)] != "0" {
                offset = i
                break
            }
        }
        return String(s[..<s.index(s.endIndex, offsetBy: offset)])
    }
}
