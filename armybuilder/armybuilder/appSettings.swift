//
//  appSettings.swift
//  armybuilder
//
//  Created by ted on 3/21/22.
//

import SwiftUI

struct appSettings: View {
    @EnvironmentObject var armyControl: armyController
    @EnvironmentObject var collectionDatas: collectionData
    var body: some View {
            ScrollView(){
                Group{
            VStack(){
                NavigationLink(destination: accountSettings(account : whoami())){
                    settingsitem(icon: "person.fill", optionname: "Account").padding()
                }
                
        
                
                NavigationLink(destination: collectionSettings().environmentObject(collectionDatas)){
                    settingsitem(icon: "archivebox.fill", optionname:"Collection").padding()
                }
            }.frame(maxWidth: 405).padding(.vertical)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray6)))
                }.padding()
            

        
            Spacer()
        }.navigationTitle("Settings").navigationViewStyle(.stack)
        

    }
}

struct appSettings_Previews: PreviewProvider {
    static var previews: some View {
        appSettings()
    }
}
