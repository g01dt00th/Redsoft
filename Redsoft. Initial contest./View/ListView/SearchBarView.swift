//
//  SearchBarView.swift
//  Redsoft. Initial contest.
//
//  Created by g01dt00th on 04.10.2020.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var viewModel: JSONViewModel
    //Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1))
    var body: some View {
        ZStack {
            Color.clear
                .overlay(
                    Rectangle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2543898225, green: 0.3117429912, blue: 0.8657471538, alpha: 1)), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 10.0)
                )


            HStack {
                Button(action: {
                    viewModel.filter = ""
                    self.viewModel.list.removeAll()
                    self.viewModel.startFrom = 0
                    self.viewModel.loadData()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.secondary)
                }).buttonStyle(PlainButtonStyle())
                .padding(.leading, 20)
                
                TextField("Я ищу", text: Binding(get: {
                    self.viewModel.filter
                }, set: { newValue in
                    self.viewModel.filter = newValue
                    self.viewModel.filterExecute()
                }))
                    .padding(.horizontal)


                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .padding(.trailing, 25)
            }
        }.frame(height: 70)
        .padding(.top)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var viewModel = JSONViewModel()
    
    static var previews: some View {
        SearchBarView().environmentObject(viewModel)
    }
}
