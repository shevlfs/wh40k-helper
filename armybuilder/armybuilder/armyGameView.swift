//
//  armyGameView.swift
//  armybuilder
//
//  Created by ted on 6/21/22.
//

import SwiftUI

struct armyGameView: View {
    @State var armyID: Int
    @EnvironmentObject var armyControl: armyController
    var body: some View {
        VStack{
            HStack{
            HStack{
                Text("M").font(.title2).fontWeight(.bold).foregroundColor(.white).padding()
                Text("WS").font(.title2).fontWeight(.bold).foregroundColor(.white).padding()
                Text("BS").font(.title2).fontWeight(.bold).foregroundColor(.white).padding()
                Text("S").font(.title2).fontWeight(.bold).foregroundColor(.white).padding()
                Text("T").font(.title2).fontWeight(.bold).foregroundColor(.white).padding()
                Text("W").font(.title2).fontWeight(.bold).foregroundColor(.white).padding()
                Text("A").font(.title2).fontWeight(.bold).foregroundColor(.white).padding()
                Text("Ld").font(.title2).fontWeight(.bold).foregroundColor(.white).padding()
                Text("Sv").font(.title2).fontWeight(.bold).foregroundColor(.white).padding()
            }.background(RoundedRectangle(cornerRadius: 15).fill(.green)).frame(maxWidth: .infinity, alignment: .leading)
            }
            ScrollView{
            ForEach(armyControl.getTroops(armyID: armyID+1)){
                troop in unitGameView(id: troop.unitid-1, factionID: armyControl.armies[armyID].factionID).frame(maxWidth: .infinity, alignment: .leading)
            }
            }
        }
    }
}

struct armyGameView_Previews: PreviewProvider {
    static var previews: some View {
        armyGameView(armyID: 0)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
