//
//  ContentView.swift
//  Valorant-Guide
//
//  Created by Manav Deep Singh Lamba on 03/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var agents = [Agent]()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
                Api().loadData { (agents) in
                    self.agents = agents
                }
            }.navigationTitle("Book List")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
