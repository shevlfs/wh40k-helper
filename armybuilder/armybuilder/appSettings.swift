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
    @State var username = whoami()
    var body: some View {
            ScrollView(){
            VStack(){
                NavigationLink(destination: accountSettings(account : username)){
                    settingsitem(icon: "person.fill", optionname: "Account").padding()
                }
                
        
                
                NavigationLink(destination: collectionSettings().environmentObject(collectionDatas)){
                    settingsitem(icon: "archivebox.fill", optionname:"Collection").padding()
                }
                
                NavigationLink(destination: armyDeletion().environmentObject(armyControl)){
                    settingsitem(icon: "trash", optionname:"Delete armies").padding()
                }
                
                
                
            }.padding(.vertical)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
            

        
            Spacer()
        }.navigationTitle("Settings").navigationViewStyle(.stack)
        

    }
}

struct appSettings_Previews: PreviewProvider {
    static var previews: some View {
        appSettings()
    }
}
