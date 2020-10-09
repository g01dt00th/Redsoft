//
//  ContentView.swift
//  Redsoft. Initial contest.
//
//  Created by g01dt00th on 02.10.2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var jsonVM: JSONViewModel
    
    var body: some View {
            ProductListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
