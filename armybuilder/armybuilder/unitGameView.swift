//
//  unitGameView.swift
//  armybuilder
//
//  Created by ted on 6/23/22.
//

import SwiftUI

struct unitGameView: View {
    @State var id: Int
    @State var factionID: Int
    var body: some View {
        Text("\(globalstats[factionID].units[id].name)")
    }
}

struct unitGameView_Previews: PreviewProvider {
    static var previews: some View {
        unitGameView(id: 0, factionID: 0)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
