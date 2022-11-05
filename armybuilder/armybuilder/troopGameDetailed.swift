//
//  troopGameDetailed.swift
//  armybuilder
//
//  Created by ted on 6/28/22.
//

import SwiftUI

struct troopGameDetailed: View {
  @EnvironmentObject var armyControl: armyController
  @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
  @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  @State var armyID: Int
  @State var unitID: Int
  var body: some View {
      if (horizontalSizeClass == .regular && verticalSizeClass == .compact){
          VStack {
              tableUnitHeader(name: globalstats[armyControl.armies[armyID].factionID].units[unitID].name)
              ScrollView {
                  if !armyControl.armies[armyID].mods[unitID + 1]!.isEmpty {
                      ForEach(armyControl.armies[armyID].mods[unitID + 1]!) {
                          mod in modGameView(mod: mod)
                      }
                  } else {
                      Text("This troop has no mods.")
                  }
              }
          }
      } else {
          VStack{
              HStack{
                  Text("Please flip your device to landscape mode.").font(.title2).fontWeight(.bold).padding().lineLimit(2)
                  Image(systemName: "arrow.turn.up.right").padding()
              }.padding()
              Spacer()
          }
      }
  }
}

/*struct troopGameDetailed_Previews: PreviewProvider {
    static var previews: some View {
        troopGameDetailed(armyID: 0, unitID: 0 ).environmentObject(armyController())
    }
}*/
