//
//  ContentView.swift
//  armybuilder
//
//  Created by ted on 29.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(){
            VStack(alignment: .leading) {
                Text("Army 1")
                .font(.title)
                HStack{
                    Text("Faction")
                        .font(.headline)
                    Spacer()
                    Text("1000 pts")
                    .font(.subheadline)
                }
        
            Spacer()
        
            }
            
        }
        .padding(.all, 22.0)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
