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
            TableHeader()
                Spacer()
            }
            ScrollView{
            ForEach(armyControl.getTroops(armyID: armyID+1)){
                troop in
                unitGameView(id: troop.unitid-1, armyID: armyID, factionID: armyControl.armies[armyID].factionID).frame(maxWidth: .infinity, alignment: .leading)
            }
            }
        }
    }
}

/*struct armyGameView_Previews: PreviewProvider {
    static var previews: some View {
        armyGameView(armyID: 0).environmentObject(armyController())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}*/


/*
 
 Text("\(globalstats[factionID].units[id].name)").fontWeight(.bold).multilineTextAlignment(.center).foregroundColor(.white).font(.title2).frame(maxWidth: 50, alignment: .leading)
 
 
 */
