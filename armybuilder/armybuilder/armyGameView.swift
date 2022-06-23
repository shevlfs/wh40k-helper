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
            ForEach(armyControl.getTroops(armyID: armyID+1)){
                troop in unitGameView(id: troop.unitid, factionID: armyControl.armies[armyID].factionID)
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
