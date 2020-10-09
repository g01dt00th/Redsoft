//
//  ProductItemView.swift
//  Redsoft. Initial contest.
//
//  Created by g01dt00th on 03.10.2020.
//

import SwiftUI

struct ProductItemView: View {
    var product: Product
    
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            Color.clear
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.secondary, lineWidth: 0.5)
                )
            
            
            VStack {
                HStack {
                    Button(action: {
                        self.isActive.toggle()
                    }, label: {
                        UrlImageView(urlString: product.imageURL)

                    }).buttonStyle(PlainButtonStyle())
                    .frame(width: 100)
                    .cornerRadius(5.0)
                    .padding(.leading)
                    .offset(y: 15)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(self.product.categories.first?.title ?? "Категория не указана")
                            .foregroundColor(.secondary)
                            .fontWeight(.light)
                        
                        Button(action: {
                            self.isActive.toggle()
                        }, label: {
                            Text(self.product.title)
                                .fontWeight(.bold)
                                .padding(.vertical)
                        }).buttonStyle(PlainButtonStyle())
                        
                        
                        Text(self.product.producer)
                            .foregroundColor(.secondary)
                            .padding(.bottom)
                        
                        Text("\(self.product.price.string()) ₽")
                            .fontWeight(.semibold)
                            .font(.headline)
                            .foregroundColor(Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1)))
                        
                        
                    }
                    Spacer()
                }
                
                NavigationLink(
                    destination: ProductDetailView(product: product),
                    isActive: $isActive,
                    label: { EmptyView() }
                    )

                BasketInListView(product: self.product)
            }
            
            
        }.frame(height: 210)
//        .padding()
        
    }
}


struct ProductItemView_Previews: PreviewProvider {
    static var basket = BasketViewModel()

    static var product = Product(id: 0, title: "Preview product", shortDescription: "Preview short description", imageURL: "https://picsum.photos/id/124/200/300", amount: 1, price: 9991.95, producer: "Preview producer", categories: [Category(id: 0, title: "Preview gategory title 1", parentID: nil),Category(id: 1, title: "Preview gategory title 2", parentID: 0), Category(id: 2, title: "Preview gategory title 2", parentID: 1)])

    
    static var previews: some View {
        ProductItemView(product: product).environmentObject(basket)
    }
}
