//
//  troopDetailedView.swift
//  armybuilder
//
//  Created by ted on 6/21/22.
//

import SwiftUI

struct troopDetailedView: View {

  @EnvironmentObject var collectionDatas: collectionData
  @State var Unit: unit
  @State var factionID: Int
  @State var armyID = Int()
  @EnvironmentObject var armyControl: armyController
  @State var unitMods = false
  @State var modID = Int()
  @State var customization = false
  var body: some View {
    ScrollView {
      VStack {
        HStack {
          Text("\(Unit.name)")
            .font(.largeTitle)
            .fontWeight(.bold)
          Spacer()
        }.padding(.horizontal)
        HStack {
          Text("\(factions[factionID].name)")
            .font(.title2)
            .fontWeight(.semibold)
          Spacer()
        }.padding(.horizontal)
        if collectionDatas.collectionDict[factionID]![Unit.id] == 0 {
          HStack {
            Text("Not in your collection").font(.title3)
              .fontWeight(.semibold)
            Spacer()
          }.padding()
        } else {
          HStack {
            Text("\(collectionDatas.collectionDict[factionID]![Unit.id]!) in your collection").font(
              .title3
            )
            .fontWeight(.semibold)
            Spacer()
          }.padding()
        }

        unitStats(Unit: Unit)
        if unitMods == true {
          if armyControl.armies[armyID].checkMods() == false {
            Button(action: {
              self.customization.toggle()

            }) {
              HStack {
                Image(systemName: "plus")
                Text("Add modifications")
                  .font(.title3)

              }
            }.sheet(
              isPresented: $customization,
              content: {
                addUnitMods(searchBarMods: modNames(), armyID: armyID, Unit: Unit, modID: modID)
                  .environmentObject(armyControl)
              }
            ).padding()
          } else {
            ForEach(armyControl.armies[armyID].mods[Unit.id]!) {
              mod in modificationDisplay(mod: mod)
            }
            Button(action: {
              self.customization.toggle()
            }) {
              HStack {
                Image(systemName: "plus")
                Text("Add modifications")
                  .font(.title3)

              }
            }.sheet(
              isPresented: $customization,
              content: {
                addUnitMods(searchBarMods: modNames(), armyID: armyID, Unit: Unit, modID: modID)
                  .environmentObject(armyControl)
              }
            ).padding()

          }
        }  // if ends here

        Spacer()
      }
    }.navigationBarTitleDisplayMode(.inline)
  }
}

/*struct troopDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        troopDetailedView(Unit: globalstats[0].units[0], factionID: 0).environmentObject(collectionData()).environmentObject(armyController())
    }
}*/
