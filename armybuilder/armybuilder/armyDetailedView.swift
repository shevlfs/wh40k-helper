//
//  armyDetailedView.swift
//  armybuilder
//
//  Created by ted on 24.02.2022.
//

import SwiftUI
import UIKit

struct armyDetailedView: View {
    @State var id = Int()
    @State var editMode = false
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var armyControl: armyController
    @StateObject var pointTargetd =  pointTarget()
    
    var body: some View {
            VStack(){
                ScrollView{
                    ZStack{
                    NavigationLink(destination: armyCustomization(armyID: id - 1).environmentObject(armyControl)){
                        VStack(alignment: .center){
                    HStack{
                        VStack(){
                                Text("Faction: \(factions[armyControl.armies[id-1].factionID].name)")
                            .font(.title2)
                            .fontWeight(.semibold).padding(.bottom, 7)
                        Text("Points: \(armyControl.armies[id-1].pointCount)")
                            .font(.title3)
                            .fontWeight(.regular)
                        }.foregroundColor(.white).padding()
                        VStack(){
                            
                            Text("Battle size:").font(.title3)
                                .fontWeight(.semibold)
                            Text("\(armyControl.armies[id-1].getBattleSize())").font(.title2)
                                .fontWeight(.semibold).padding(.bottom, 7)
                            Text("CP: \(armyControl.armies[id-1].getCommandPoints())").font(.title3)
                                .fontWeight(.regular)
                        }.foregroundColor(.white).padding(14)
                                                    
                    }.padding(7).background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.green))
                        }.background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.green))
                    }.padding()
                    }.padding()
                    Spacer()
                    VStack{
                ForEach(armyControl.getTroops(armyID: id)){
                    unit in troopDisplay(unitCount: armyControl.armies[id-1].troops[unit.unitid] ?? 0,unitname: globalstats[armyControl.armies[id-1].factionID].units[unit.unitid-1].name, pointcount: globalstats[armyControl.armies[id-1].factionID].units[unit.unitid-1].pts, Unit: globalstats[armyControl.armies[id-1].factionID].units[unit.unitid-1], faction: armyControl.armies[id-1].factionID, armyID: id-1)
                    
                }
                    }
                }
    
                
            }.navigationTitle(armyControl.armies[id-1].name).toolbar {
            ToolbarItemGroup(placement: .primaryAction){
                HStack{
                    NavigationLink(destination: armyGameView(armyID: id-1 ).environmentObject(armyControl).onAppear(perform:{
                            let value = UIInterfaceOrientation.landscapeLeft.rawValue
                            UIDevice.current.setValue(value, forKey: "orientation")
                        
                    })){
                        Image(systemName: "viewfinder")
                    }
                    
                Button(action: {
                    self.editMode.toggle()
                }) {
                    Label("Add",systemImage:"pencil")}.sheet(isPresented: $editMode){
                        editArmy(factionfile: armyControl.armies[id-1].factionID, armyID: id-1, collectionShowcase: collectionDatas.emptyChecker(factionID: armyControl.armies[id-1].factionID)).environmentObject(armyControl).environmentObject(collectionDatas).environmentObject(pointTargetd).onDisappear(perform: {
                            updatearmy(army: armyControl.armies[id-1])
                        })
                    }
                    }
        }
            }
    }
}

/* struct armyDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        armyDetailedView().environmentObject(armyController()).environmentObject(collectionData())
    }
}
} */
