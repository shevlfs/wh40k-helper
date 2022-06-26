//
//  addCustomMod.swift
//  armybuilder
//
//  Created by ted on 6/24/22.
//

import SwiftUI
import Combine


struct addCustomMod: View {
    @EnvironmentObject var armyControl: armyController
    @State var temppts = Int()
    @State var temptype = String()
    @State var armyID: Int
    @State var modID = 0
    @State var Unit: unit
    
    
    @State var Range = String()
    @State var TypeM = String()
    @State var PTS = Int()
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Range").font(.title2).fontWeight(.semibold)
                Spacer()
                TextField("", text:
                            $Range).padding().foregroundColor(.white)
                    .frame(width: 150, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemGray2)))
            }.padding()
            Text("\(armyControl.armies[armyID].mods[Unit.id]![modID].range)")
            HStack{
                Text("Type").font(.title2).fontWeight(.semibold)
                Spacer()
                TextField("", text: $TypeM).padding().foregroundColor(.white)
                    .frame(width: 150, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemGray2)))
            }.padding()
            
            HStack{
                Text("Point cost").font(.title2).fontWeight(.semibold)
                Spacer()
                TextField("", value: $PTS, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .onReceive(Just(temppts)) { newValue in
                    let filtered = newValue
                    if filtered != newValue {
                        PTS = filtered
                    }
                }.padding().foregroundColor(.white)
                    .frame(width: 150, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemGray2)))
            }.padding()
            
            
            
            
            
            
        }
    }
}

struct addCustomMod_Previews: PreviewProvider {
    static var previews: some View {
        addCustomMod(armyID: 0, Unit: globalstats[0].units[0])
    }
}
