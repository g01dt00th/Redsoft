//
//  BasketDetailView.swift
//  Redsoft. Initial contest.
//
//  Created by Роенко Денис on 08.10.2020.
//

import SwiftUI

struct BasketDetailView: View {
    @EnvironmentObject var basket: BasketViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var basketArray = [BasketModel]()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .frame(width: 10, height: 20)
                        Text("Назад")
                    }
                })
                .padding()
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(basketArray) { item in
                        ProductItemView(product: Product(id: item.id, title: item.title, shortDescription: item.shortDescription, imageURL: item.imageURL, amount: item.amount, price: item.price, producer: item.producer, categories: item.categories)).padding(.horizontal)
                    }
                }
            }
            
            Divider()
            
            HStack {
                Button("Оформить", action: {
                    self.basketArray.removeAll()
                    self.basket.list.forEach { _, value in
                        self.basketArray.append(value)
                    }
                }).padding()
                
                Divider()
                Button(action: {
                    self.basketArray.removeAll()
                    self.basket.list.removeAll()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Очистить корзину")
                }).padding()
            }.frame(height: 30)
            
            Divider()
            .padding(.bottom)
            
        }.navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.basket.list.forEach { _, value in
                self.basketArray.append(value)
            }
        }
    }
}

struct BasketDetailView_Previews: PreviewProvider {
    static var basket = BasketViewModel()
    
    static var previews: some View {
        BasketDetailView().environmentObject(basket)
    }
}
