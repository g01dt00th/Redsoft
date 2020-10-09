//
//  BasketViewModel.swift
//  Redsoft. Initial contest.
//
//  Created by Роенко Денис on 06.10.2020.
//

import SwiftUI


class BasketViewModel: ObservableObject {
    @Published var list = Dictionary<Int, BasketModel>()
    
    func addToBasket(_ product: Product) {
        if list.index(forKey: product.id) != nil {
            list[product.id]!.inBasket += 1

            if list[product.id]!.inBasket > product.amount {
                list[product.id]?.inBasket = product.amount
            }
        } else {
            let value = BasketModel(id: product.id, title: product.title, shortDescription: product.shortDescription, imageURL: product.imageURL, amount: product.amount, price: product.price, producer: product.producer, categories: product.categories, inBasket: 1)


            list[product.id] = value

        }

    }
    
    func removeFromBasket(_ product: Product) {
        if list[product.id] != nil {
            list[product.id]!.inBasket -= 1
            if list[product.id]!.inBasket < 1 {
                list[product.id] = nil
            }
        }
    }
}
