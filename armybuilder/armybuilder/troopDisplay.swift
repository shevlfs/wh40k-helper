//
//  troopDisplay.swift
//  armybuilder
//
//  Created by ted on 6/18/22.
//

import SwiftUI

struct troopDisplay: View {
    @State var unitCount: Int
    @State var unitname = String()
    @State var pointcount = Int()
    @State var Unit: unit
    @State var faction = Int()
    @State var armyID: Int
    @EnvironmentObject var pointTarget: pointTarget
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var armyControl: armyController
    var body: some View {
        VStack(alignment: .trailing) {
            NavigationLink(destination: troopDetailedView(Unit: Unit, factionID: faction,armyID: armyID, unitMods: true).environmentObject(collectionDatas).environmentObject(armyControl)){
            Text(unitname)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.teal)
                )
            }
            pickerView()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
    }
}

extension troopDisplay {
    @ViewBuilder
    private func pickerView() -> some View {
        HStack {
            Text("\(pointcount) pts").foregroundColor(.white)
                .padding(.vertical, 8).padding(.horizontal, 40)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.teal))
                
            Spacer()
             
                
            
            Text("\(unitCount)").foregroundColor(.white)
                .padding(.vertical, 8).padding(.horizontal, 40)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.teal))
        }
    }
}


struct troopDisplay_Previews: PreviewProvider {
    static var previews: some View {
        troopDisplay(unitCount: 0, Unit: globalstats[0].units[0], armyID: 0)
    }
}
