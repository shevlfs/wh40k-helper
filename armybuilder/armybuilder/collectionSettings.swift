//
//  collectionSettings.swift
//  armybuilder
//
//  Created by ted on 6/13/22.
//

import SwiftUI

struct collectionSettings: View { // View предлагающий выбрать фракцию юнитов для изменения коллекции
  @EnvironmentObject var collectionDatas: collectionData
  var body: some View {
    ScrollView(.vertical) {
        HStack {
          Text("Add units to collection").font(.largeTitle).fontWeight(.semibold)
          Spacer()
        }.padding()
      VStack {
        HStack {
          Text("Choose the faction of your units ").fontWeight(.regular).padding(
            [.leading, .bottom, .trailing]
          ).font(.title3)
        }
        VStack(alignment: .center) {
          ForEach(factions) { faction in
            NavigationLink(
              destination: collectionAddUnits(factionfile: faction.id).environmentObject(
                collectionDatas)
            ) {
              ZStack {
                Rectangle().fill(Color(UIColor.systemGray4)).frame(width: 370.0, height: 55)
                  .cornerRadius(10).padding(.all, 10.0)
                Text(faction.name)
                  .font(.headline)
                  .foregroundColor(Color.black)
              }
            }
          }
        }
      }
    }.navigationViewStyle(.stack)
  }
}
