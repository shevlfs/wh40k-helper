//
//  appSettings.swift
//  armybuilder
//
//  Created by ted on 3/21/22.
//

import SwiftUI

struct appSettings: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                Text("Settings").font(.title).fontWeight(.semibold).padding()
                Spacer()
            }.padding(.top, 20)
        
            Spacer()
        }

    }
}

struct appSettings_Previews: PreviewProvider {
    static var previews: some View {
        appSettings()
    }
}
