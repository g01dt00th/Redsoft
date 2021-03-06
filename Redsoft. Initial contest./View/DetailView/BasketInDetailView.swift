//
//  BasketInDetailView.swift
//  Redsoft. Initial contest.
//
//  Created by Роенко Денис on 09.10.2020.
//

import SwiftUI


struct BasketInDetailView: View {
    @EnvironmentObject var basket: BasketViewModel
    
    var product: Product

    
    var body: some View {
        HStack {
            Spacer()
            if self.basket.list[self.product.id] == nil {
                Button(action: {
                    withAnimation{
                        self.basket.addToBasket(self.product)
                    }
                }, label: {
                    HStack(spacing: 10){
                        Text("В корзину")
                            .foregroundColor(.white)
                            .font(.headline)
                        Image(systemName: "cart.badge.plus")
                            .resizable()
                            .frame(width: 25, height: 20)
                            .foregroundColor(.white)
                    }.frame(width: 151.5, height: 52.5)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1)), Color.blue, Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }).buttonStyle(PlainButtonStyle())
            } else {
                HStack(spacing: 15) {
                    Button(action: {
                        if self.basket.list[self.product.id]!.inBasket == 1 {
                            withAnimation {
                                self.basket.removeFromBasket(self.product)
                            }
                        } else {
                            self.basket.removeFromBasket(self.product)
                        }

                    }, label: {
                        Text("-")
                            .font(.headline)
                            .foregroundColor(.white)


                        
                    }).buttonStyle(PlainButtonStyle())
                    
//                    Divider().background(Color.white)
                    Rectangle()
                        .frame(width: 0.5)
                        .foregroundColor(.white)
                    
                    Text("\(self.basket.list[self.product.id]!.inBasket) шт")
                        .font(.headline)
                        .foregroundColor(.white)
                    
//                    Divider().background(Color.white)
                    Rectangle()
                        .frame(width: 0.5)
                        .foregroundColor(.white)

                    Button(action: {

                            self.basket.addToBasket(self.product)

                    }, label: {
                        Text("+")
                            .font(.headline)
                            .foregroundColor(.white)

                        
                    }).buttonStyle(PlainButtonStyle())


                }.frame(width: 151.5, height: 52.5)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1)), Color.blue, Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            
        }.frame(height: 55)
        .padding(.trailing)
    }
}

struct BasketInDetailView_Previews: PreviewProvider {
    static var basket = BasketViewModel()
    
    static var product = Product(id: 0, title: "Preview product", shortDescription: "Preview short description", imageURL: "https://picsum.photos/id/124/200/300", amount: 1, price: 9991.95, producer: "Preview producer", categories: [Category(id: 0, title: "Preview gategory title 1", parentID: nil),Category(id: 1, title: "Preview gategory title 2", parentID: 0), Category(id: 2, title: "Preview gategory title 2", parentID: 1)])
    
    static var previews: some View {
        BasketInDetailView(product: product).environmentObject(basket)
    }
}
