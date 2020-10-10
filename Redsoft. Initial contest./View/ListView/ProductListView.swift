//
//  ProductListView.swift
//  Redsoft. Initial contest.
//
//  Created by g01dt00th on 03.10.2020.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var viewModel: JSONViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBarView()
                    
                    if viewModel.list.isEmpty {
                        ActivityView()
                            .padding(.top, 20)
                        Spacer()
                    } else {
                        
                        if #available(iOS 14.0, *) {
                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVStack(spacing: 0) {
                                    ForEach(viewModel.list) { product in
                                        ProductItemView(product: product)
                                            .padding()
                                            .onAppear{ self.viewModel.loadNext(product) }
                                    }
                                }
                            }
                        } else {
                            List(viewModel.list) { product in
                                
                                ProductItemView(product: product)
                                    .onAppear{ self.viewModel.loadNext(product) }
                                
                            }
                        }
                    }
                }
                GeometryReader { proxy in
                    BasketButtonView()
                        .position(x: proxy.size.width - 50, y: proxy.size.height - 70)
                }
                
                
            }.navigationBarHidden(true)
            .navigationBarTitle("")
            
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var list = JSONViewModel()
    static var basket = BasketViewModel()
    
    static var previews: some View {
        ProductListView().environmentObject(list).environmentObject(basket)
    }
}
