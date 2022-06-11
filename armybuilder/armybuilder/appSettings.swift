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
            ScrollView(){
            VStack(){
                settingsitem(icon: "person.fill", optionname: "Account").padding()
                settingsitem(icon: "rectangle.3.group", optionname:"Collection").padding()
            }.padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
            }
            

        
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
