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
        List(agents) { agent in
            
            VStack(alignment: .leading) {
                
                Text("\(agent.displayName)")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding(.bottom)
                
            }
            
        }
            .onAppear() {
                Api().loadData { (agents) in
                    self.agents = agents
                }
            }.navigationTitle("Agent List")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
