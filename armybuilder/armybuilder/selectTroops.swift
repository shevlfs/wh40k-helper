//
//  selectTroops.swift
//  armybuilder
//
//  Created by ted on 3/23/22.
//

import SwiftUI

struct selectTroops: View {
    @State var factionID = Int()
    @EnvironmentObject var rootData: AddArmyViewModel
    var body: some View {
        ScrollView(.vertical){
        VStack(alignment: .center){
            HStack {
                    Text("Select troops for your army ")
                    .fontWeight(.regular)
                    .font(.title3)
                Spacer()
            }
            VStack(alignment: .center, spacing: 20){
                ForEach(rootData.units){ unit in
                    troopCountSelect(unitcount: Binding(get: {
                        return rootData.unitCount[unit] ?? 0
                    }, set: { v in
                        rootData.unitCount[unit] = v
                    }), unitname: unit.name)
                }
                }
            }
        .padding(.horizontal, 20)
        }.navigationBarBackButtonHidden(true)
            .navigationTitle("Add a new army!")
            .onAppear {
                rootData.factionID = Int16(factionID)
            }
}
}

struct selectTroops_Previews: PreviewProvider {
    static var previews: some View {
        selectTroops()
            .environmentObject(AddArmyViewModel(context: DataController().container.viewContext))
    }
}
