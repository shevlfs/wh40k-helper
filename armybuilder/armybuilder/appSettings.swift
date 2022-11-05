//
//  appSettings.swift
//  armybuilder
//
//  Created by ted on 3/21/22.
//

import SwiftUI

struct appSettings: View {  // View с настройками приложения
  @EnvironmentObject var collectionDatas: collectionData
  @EnvironmentObject var reloadControl: reloadController
  var body: some View {
    if reloadControl.logOutPerformed {
      VStack {}.navigationBarBackButtonHidden(true).onAppear(perform: {
        reloadControl.showSettings = false
      })
    } else {
      Group {
        HStack {
          Text("Settings").font(.largeTitle).fontWeight(.semibold)
          Spacer()
        }
        VStack {
          NavigationLink(
            destination: accountSettings().environmentObject(reloadControl)
          ) {
            settingsitem(icon: "person.fill", optionname: "Account").padding()
          }
          NavigationLink(
            destination: collectionSettings().onAppear(perform: {
              saveCollection(collectionDatas: collectionDatas)
            }).environmentObject(collectionDatas)
          ) {
            settingsitem(icon: "archivebox.fill", optionname: "Collection").padding()
          }
        }.frame(maxWidth: 405).padding(.vertical)
          .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray6)))
      }.navigationViewStyle(.stack).padding()
      Spacer()
    }
  }
}

