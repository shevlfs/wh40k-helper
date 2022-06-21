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
    var body: some View {
        VStack{
            
        }.navigationTitle("\(Unit.name)")
    }
}

struct troopDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        troopDetailedView(Unit: globalstats[0].units[0])
    }
}
