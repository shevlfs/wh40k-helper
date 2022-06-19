//
//  armyDetailedView.swift
//  armybuilder
//
//  Created by ted on 24.02.2022.
//

import SwiftUI

struct armyDetailedView: View {
    @State var id = Int()
    @State var editMode = false
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var armyControl: armyController
    
    
    var body: some View {
            VStack(){
                HStack{
                        VStack(){
                            Text("Faction: \(factions[armyControl.armies[id-1].factionID].name)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Points: \(armyControl.armies[id-1].pointCount)")
                        .font(.title3)
                        .fontWeight(.regular)
                        }.foregroundColor(.white)
                            .frame(width: 270, height: 30)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.green))
                }.padding()
                Spacer()
                ScrollView{
                    VStack{
                ForEach(armyControl.getTroops(armyID: id)){
                    unit in NavigationLink(destination: unitDetailedView() ){troopDisplay(unitcount: armyControl.armies[id-1].troops[unit.unitid] ?? 0,unitname: globalstats[armyControl.armies[id-1].factionID].units[unit.unitid-1].name, pointcount: globalstats[armyControl.armies[id-1].factionID].units[unit.unitid-1].pts)
                    }
                }
                    }
                }
    
                
        }.navigationTitle("Army \(id)").toolbar {
            ToolbarItemGroup(placement: .primaryAction){
                Button(action: {
                    self.editMode.toggle()
                }) {
                    Label("Add",systemImage:"pencil")}.sheet(isPresented: $editMode){
                        editArmy()
                    }

            }
    }
}

struct armyDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        armyDetailedView().environmentObject(armyController()).environmentObject(collectionData())
    }
}
}
