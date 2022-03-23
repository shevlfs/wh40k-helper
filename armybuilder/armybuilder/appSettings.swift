//
//  appSettings.swift
//  armybuilder
//
//  Created by ted on 3/21/22.
//

import SwiftUI

struct appSettings: View {
    var body: some View {
        NavigationView{
        VStack(alignment: .leading){
            HStack(){
                Text("Settings").font(.headline).fontWeight(.regular).padding()
                Spacer()
            }.padding(.top, 20)
        
            Spacer()
        }.navigationTitle("Settings")
        }

    }
}

struct appSettings_Previews: PreviewProvider {
    static var previews: some View {
        appSettings()
    }
}
