//
//  unitGameView.swift
//  armybuilder
//
//  Created by ted on 6/23/22.
//

import SwiftUI

struct unitGameView: View {
    @State var id: Int
    @State var armyID: Int
    @State var factionID: Int
    var body: some View {
        HStack{
            NavigationLink(destination: troopGameDetailed(armyID: armyID, unitID: id)){
        HStack{
        HStack(alignment: .center, spacing: nil){
            Group{
            Text("\(globalstats[factionID].units[id].m)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: 50, alignment: .leading)
            Text("\(globalstats[factionID].units[id].ws)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: 50, alignment: .leading)
            Text("\(globalstats[factionID].units[id].bs)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: 50, alignment: .leading)
            Text("\(globalstats[factionID].units[id].s)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: 50, alignment: .leading)
            Text("\(globalstats[factionID].units[id].t)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: 50, alignment: .leading)
            Text("\(globalstats[factionID].units[id].w)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: 50, alignment: .leading)
            Text("\(globalstats[factionID].units[id].a)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: 50, alignment: .leading)
            Text("\(globalstats[factionID].units[id].ld)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: 50, alignment: .leading)
            Text("\(globalstats[factionID].units[id].sv)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(maxWidth: 50, alignment: .leading)
            }

        }.padding()
        }.background(RoundedRectangle(cornerRadius: 10).fill(.green)).padding()}
            Spacer()
            Text("\(globalstats[factionID].units[id].name)").fontWeight(.bold).multilineTextAlignment(.center).foregroundColor(.black).font(.title2).frame(maxWidth: 215, alignment: .trailing)
        }
    }
}

struct unitGameView_Previews: PreviewProvider {
    static var previews: some View {
        unitGameView(id: 20, armyID: 0, factionID: 0)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
