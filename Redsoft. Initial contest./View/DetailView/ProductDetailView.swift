//
//  ProductDetailView.swift
//  Redsoft. Initial contest.
//
//  Created by Роенко Денис on 08.10.2020.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var basket: BasketViewModel
    @Environment(\.presentationMode) var presentationMode

    var product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            Text(product.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(product.producer)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.vertical)

            HStack(alignment: .top){
                UrlImageView(urlString: product.imageURL)
                    .frame(width: UIScreen.main.bounds.width / 3)
                    .cornerRadius(5.0)
                VStack(alignment: .leading){
                    Text(product.shortDescription)
                        .font(.headline)
                        .lineLimit(3)
                        .padding(.bottom)
                    
                    ForEach(product.categories) { category in
                        Text(category.title)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.vertical, 5)
                    }
                }
            }.padding(.bottom)
            
            HStack {
                Text("\(self.product.price.string()) ₽")
                    .font(.title)
                    .fontWeight(.semibold)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1)))
                
                BasketInDetailView(product: product)
            }
            
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Назад")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 151.5, height: 52.5)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1)), Color.blue, Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }).buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                NavigationLink(
                    destination: BasketDetailView(),
                    label: {
                        Text("К заказу")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 151.5, height: 52.5)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1)), Color.blue, Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    }).padding(.trailing)
            }

            
            
            Spacer()
        }.padding(.leading)
        .navigationBarHidden(true)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var basket = BasketViewModel()
    
    static var product = Product(id: 0, title: "Preview product", shortDescription: "Preview short description", imageURL: "https://picsum.photos/id/124/200/300", amount: 1, price: 9991.95, producer: "Preview producer", categories: [Category(id: 0, title: "Preview gategory title 1", parentID: nil),Category(id: 1, title: "Preview gategory title 2", parentID: 0), Category(id: 2, title: "Preview gategory title 2", parentID: 1)])
    
    static var previews: some View {
        ProductDetailView(product: product).environmentObject(basket)
    }
}
