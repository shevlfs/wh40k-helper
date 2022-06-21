//
//  selectTroops.swift
//  armybuilder
//
//  Created by ted on 3/23/22.
//

import SwiftUI



struct editArmy: View {
    @State var factionfile = Int()
    @State var currentpoints = Int()
    @State var targetMenu = false
    @State var targetPopUp = false
    @State var armyID: Int
    @EnvironmentObject var pointTarget: pointTarget
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var armyControl: armyController
    @State var collectionShowcase: Bool
    
    var body: some View {
        NavigationView(){
        VStack(){
            HStack(){
                if (pointTarget.targetpointbool == false){
                Button(action:{ self.targetMenu.toggle()}){
                    Text("\(armyControl.armies[armyID].pointCount) pts").foregroundColor(.white)
                    .frame(width: 195, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green)).sheet(isPresented: $targetMenu){
                                targetPicker().environmentObject(pointTarget)
                            }
                }
                

            } else {
                
                if (armyControl.armies[armyID].pointCount > pointTarget.count){
                Button(action:{ self.targetMenu.toggle()}){
                Text("\(armyControl.armies[armyID].pointCount) pts / \(pointTarget.count) pts ").foregroundColor(.white)
                .frame(width: 195, height: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.red)).sheet(isPresented: $targetMenu){
                            targetPicker().environmentObject(pointTarget)
                        }
            }

                
                } else {
                    Button(action:{ self.targetMenu.toggle()}){
                        Text("\(armyControl.armies[armyID].pointCount) pts / \(pointTarget.count) pts ").foregroundColor(.white)
                    .frame(width: 195, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green)).sheet(isPresented: $targetMenu){
                                targetPicker().environmentObject(pointTarget)
                            }
                }
                    
                }
            }
            }.padding()
            
            
            if(collectionShowcase == false){
            ScrollView(.vertical){
            VStack(alignment: .center){
                HStack{
                Text("Troops:").font(.title)
                    .fontWeight(.bold)
                    Spacer()
                }.padding()
                ForEach(globalstats[factionfile].units){unit in
                    ZStack(){
                        troopEditSelect(unitcount: 0, unitname: unit.name, pointcount: unit.pts, unit: unit, armyID: armyID).environmentObject(pointTarget).environmentObject(armyControl)
                    }
                }
                }
            }
            } else {
                ScrollView(.vertical){
                    VStack(){
                        HStack{
                        Text("In your collection:")
                            .font(.title)
                            .fontWeight(.bold)
                            Spacer()
                        }.padding()
                        VStack(alignment: .center){
                            ForEach(
                                collectionDatas.getUnits(factionID: factionfile)
                            ){unit in
                                ZStack(){
                                    troopCollectionCount(unitcount: armyControl.armies[armyID].troops[unit.unitid] ?? 999, unitname: globalstats[factionfile].units[unit.unitid-1].name, pointcount: globalstats[factionfile].units[unit.unitid-1].pts, unit: globalstats[factionfile].units[unit.unitid-1], faction: factionfile).environmentObject(pointTarget).environmentObject(armyControl)
                                    
                                }
                            }
                        }.padding(.vertical)
                        
                        
                        
                        
                        
                    }
                VStack(alignment: .center){
                    HStack{
                    Text("Troops:").font(.title)
                        .fontWeight(.bold)
                        Spacer()
                    }.padding()
                    ForEach(globalstats[factionfile].units){unit in
                        ZStack(){
                            troopEditSelect(unitcount: armyControl.armies[armyControl.armies.count-1].troops[unit.id] ?? 999, unitname: unit.name, pointcount: unit.pts, unit: unit, armyID: armyID ).environmentObject(pointTarget).environmentObject(armyControl)
                        }
                    }
                    }
                }
                
                
                
                
                
                
            }
        }
        .navigationBarTitle("Edit Army")
        }
        }
        
}

/*struct editArmy_Previews: PreviewProvider {
    static var previews: some View {
        selectTroops(factionfile: 0, collectionShowcase: true).environmentObject(pointTarget()).environmentObject(collectionData())
    }
}*/


