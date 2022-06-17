//
//  selectTroops.swift
//  armybuilder
//
//  Created by ted on 3/23/22.
//

import SwiftUI


class pointTarget: ObservableObject{
    @Published var count = 0
    @Published var targetpointbool = false
    @Published var currentPoints = 0
}


struct selectTroops: View {
    @State var factionfile = Int()
    @State var currentpoints = Int()
    @State var targetMenu = false
    @State var targetPopUp = false
    @EnvironmentObject var pointTarget: pointTarget
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var armyControl: armyController
    @State var collectionShowcase: Bool
    
    var body: some View {
        VStack(){
            HStack(){
                if (pointTarget.targetpointbool == false){
                Button(action:{ self.targetMenu.toggle()}){
                    Text("\(armyControl.armies[armyControl.armies.count-1].pointCount) pts").foregroundColor(.white)
                    .frame(width: 195, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green)).sheet(isPresented: $targetMenu){
                                targetPicker().environmentObject(pointTarget)
                            }
                }
                

            } else {
                
                if (armyControl.armies[armyControl.armies.count-1].pointCount > pointTarget.count){
                Button(action:{ self.targetMenu.toggle()}){
                Text("\(armyControl.armies[armyControl.armies.count-1].pointCount) pts / \(pointTarget.count) pts ").foregroundColor(.white)
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
                        Text("\(armyControl.armies[armyControl.armies.count-1].pointCount) pts / \(pointTarget.count) pts ").foregroundColor(.white)
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
                ForEach(globalstats[factionfile].units){unit in
                    ZStack(){
                        troopCountSelect(unitcount: 0, unitname: unit.name, pointcount: unit.pts, unit: unit).environmentObject(pointTarget).environmentObject(armyControl)
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
                                    troopCollectionCount(unitcount: 0, unitname: globalstats[factionfile].units[unit.unitid-1].name, pointcount: globalstats[factionfile].units[unit.unitid-1].pts).environmentObject(pointTarget).environmentObject(armyControl)
                                    
                                }
                            }
                        }.padding()
                        
                        
                        
                        
                        
                    }
                VStack(alignment: .center){
                    ForEach(globalstats[factionfile].units){unit in
                        ZStack(){
                            troopCountSelect(unitcount: 0, unitname: unit.name, pointcount: unit.pts, unit: unit).environmentObject(pointTarget).environmentObject(armyControl)
                        }
                    }
                    }
                }
                
                
                
                
                
                
            }
            
            
        }.navigationTitle("Add a new army!")
        }
        
}

struct selectTroops_Previews: PreviewProvider {
    static var previews: some View {
        selectTroops(factionfile: 0, collectionShowcase: true).environmentObject(pointTarget()).environmentObject(collectionData())
    }
}

