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
    
    
    var body: some View {
        VStack(){
            HStack(){
                if (pointTarget.targetpointbool == false){
                Button(action:{ self.targetMenu.toggle()}){
                    Text("\(pointTarget.currentPoints) pts").foregroundColor(.white)
                    .frame(width: 195, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green)).sheet(isPresented: $targetMenu){
                                targetPicker().environmentObject(pointTarget)
                            }
                }
                

            } else {
                
                if (pointTarget.currentPoints > pointTarget.count){
                Button(action:{ self.targetMenu.toggle()}){
                Text("\(pointTarget.currentPoints) pts / \(pointTarget.count) pts ").foregroundColor(.white)
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
                    Text("\(pointTarget.currentPoints) pts / \(pointTarget.count) pts ").foregroundColor(.white)
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
            ScrollView(.vertical){
            VStack(alignment: .center){
                ForEach(globalstats[factionfile].units){unit in
                    ZStack(){
                        troopCountSelect(unitcount: 0, unitname: unit.name, pointcount: unit.pts).environmentObject(pointTarget)
                    }
                }
                }
            }
        }.navigationTitle("Add a new army!")
        }
        
}

struct selectTroops_Previews: PreviewProvider {
    static var previews: some View {
        selectTroops().environmentObject(pointTarget())
    }
}

