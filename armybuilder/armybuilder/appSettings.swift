//
//  appSettings.swift
//  armybuilder
//
//  Created by ted on 3/21/22.
//

import SwiftUI

struct appSettings: View { // View с настройками приложения
    @EnvironmentObject var armyControl: armyController
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var reloadControl: reloadController
    var body: some View {
            ScrollView(){
                Group{
            VStack(){
                NavigationLink(destination: accountSettings(account : whoami()).onAppear(perform: {UINavigationBar.setAnimationsEnabled(false)}).onDisappear(perform: {UINavigationBar.setAnimationsEnabled(true)}).environmentObject(reloadControl).environmentObject(collectionDatas).environmentObject(armyControl)){
                    settingsitem(icon: "person.fill", optionname: "Account").padding()
                }
                NavigationLink(destination: collectionSettings().environmentObject(collectionDatas)){
                    settingsitem(icon: "archivebox.fill", optionname:"Collection").padding()
                }
            }.frame(maxWidth: 405).padding(.vertical)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray6)))
                }.padding()
            Spacer()
        }.navigationBarTitle("Settings").navigationViewStyle(.stack)
    }
}

struct appSettings_Previews: PreviewProvider {
    static var previews: some View {
        appSettings()
    }
}
