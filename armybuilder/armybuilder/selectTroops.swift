//
//  selectTroops.swift
//  armybuilder
//
//  Created by ted on 3/23/22.
//

import SwiftUI

struct selectTroops: View {
    @State var factionfile = Int()
    @State var currentpoints = Int()
    @State var targetpoint = false
    @State var targetMenu = false
    @State var targetPopUp = false
    @State var pointTarget = Int()
    var body: some View {
        VStack(){
            HStack(){
            if (targetpoint == false){
                Button(action:{ self.targetMenu.toggle()}){
                Text("\(currentpoints) pts").foregroundColor(.white)
                    .frame(width: 150, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green))
                }
                .confirmationDialog("Select target", isPresented: $targetMenu,titleVisibility: .visible){
                    Button("Select target"){
                        targetpoint = true
                    }
                    Button("No target"){
                        targetpoint = false
                    }
                }

            } else {
                Button(action:{ self.targetMenu.toggle()}){
                Text("\(currentpoints) pts / \(pointTarget) pts ").foregroundColor(.white)
                    .frame(width: 350, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green))
                }
                .confirmationDialog("Select target", isPresented: $targetMenu,titleVisibility: .visible){
                    Button("Select target"){
                        targetpoint = true
                    }
                    Button("No target"){
                        targetpoint = false
                    }
                }

                
            }
            }.padding()
            ScrollView(.vertical){
            VStack(alignment: .center){
                ForEach(globalstats[factionfile].units){unit in
                    ZStack(){
                        troopCountSelect(unitcount: 0, unitname: unit.name, pointcount: unit.pts)
                    }
                }
                }
            }
        }.navigationTitle("Add a new army!")
        }
        
}

struct selectTroops_Previews: PreviewProvider {
    static var previews: some View {
        selectTroops(currentpoints: 1000, pointTarget: 1500)
    }
}
