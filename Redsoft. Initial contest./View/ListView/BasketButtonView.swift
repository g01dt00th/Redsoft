//
//  BasketButtonView.swift
//  Redsoft. Initial contest.
//
//  Created by Роенко Денис on 08.10.2020.
//

import SwiftUI

struct BasketButtonView: View {
    @EnvironmentObject var basket: BasketViewModel

    var body: some View {
        VStack {
            if self.basket.list.isEmpty {
                EmptyView()
            } else {
                NavigationLink(
                    destination: BasketDetailView(),
                    label: {
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1)), Color.blue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                            
                            Image(systemName: "cart.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .offset(x: -1)
                                
                        }

                    })
            }
        }.frame(width: 50, height: 50)
        .shadow(radius: 5)
    }
}

struct BasketButtonView_Previews: PreviewProvider {
    static var basket = BasketViewModel()
    
    static var previews: some View {
        BasketButtonView().environmentObject(basket)
    }
}
