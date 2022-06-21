//
//  troopDetailedView.swift
//  armybuilder
//
//  Created by ted on 6/21/22.
//

import SwiftUI


struct troopDetailedView: View {

    @EnvironmentObject var collectionDatas: collectionData
    @State var Unit : unit
    @State var factionID: Int
    var body: some View {
        VStack{
            HStack{
                Text("\(Unit.name)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }.padding(.horizontal)
            HStack{
                Text("\(factions[factionID].name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }.padding(.horizontal)
            if (collectionDatas.collectionDict[factionID]![Unit.id] == 0){
                HStack{
                Text("Not in your collection").font(.title3)
                        .fontWeight(.semibold)
                Spacer()
                }.padding()
            } else {
                HStack{
                    Text("\(collectionDatas.collectionDict[factionID]![Unit.id]!) in your collection").font(.title3)
                        .fontWeight(.semibold)
                Spacer()
                }.padding()
            }
            
            unitStats(Unit: Unit)
            Spacer()
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct troopDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        troopDetailedView(Unit: globalstats[0].units[0], factionID: 0)
    }
}
