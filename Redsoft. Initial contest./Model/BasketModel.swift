//
//  BasketModel.swift
//  Redsoft. Initial contest.
//
//  Created by Роенко Денис on 06.10.2020.
//

import Foundation

struct BasketModel: Identifiable {
 
    let id: Int
    let title, shortDescription: String
    let imageURL: String
    let amount: Int
    let price: Double
    let producer: String
    let categories: [Category]
    var inBasket: Int = 0

}



