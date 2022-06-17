//
//  appSettings.swift
//  armybuilder
//
//  Created by ted on 3/21/22.
//

import SwiftUI

struct appSettings: View {
    @EnvironmentObject var collectionDatas: collectionData
    var body: some View {
        NavigationView{
            ScrollView(){
            VStack(){
                NavigationLink(destination: accountSettings()){
                    settingsitem(icon: "person.fill", optionname: "Account").padding()
                }
                
        
                
                NavigationLink(destination: collectionSettings().environmentObject(collectionDatas)){
                    settingsitem(icon: "archivebox.fill", optionname:"Collection").padding()
                }
                
            }.padding(.vertical)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
            

        
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
