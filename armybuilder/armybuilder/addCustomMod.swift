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
    
    
    @State var Name = String()
    @State var Range = String()
    @State var TypeM = String()
    @State var S = String()
    @State var AP = Int()
    @State var D = String()
    @State var PTS = Int()
    @State var Count = Int()
    
    
    
    var body: some View {
        ScrollView{
        VStack{
        VStack{
            HStack{
                Text("Name").font(.title2).fontWeight(.semibold)
                Spacer()
                TextField("", text:
                            $Name).padding().foregroundColor(.white)
                    .frame(width: 150, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemGray2)))
            }.padding()
            
            
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
                Text("S").font(.title2).fontWeight(.semibold)
                Spacer()
                TextField("", text:
                            $S).padding().foregroundColor(.white)
                    .frame(width: 150, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemGray2)))
            }.padding()
            HStack{
                Text("AP").font(.title2).fontWeight(.semibold)
                Spacer()
                TextField("", value: $AP, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .onReceive(Just(AP)) { newValue in
                    let filtered = newValue
                    if filtered != newValue {
                        AP = filtered
                    }
                }.padding().foregroundColor(.white)
                    .frame(width: 150, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemGray2)))
            }.padding()
            HStack{
                Text("D").font(.title2).fontWeight(.semibold)
                Spacer()
                TextField("", text:
                            $D).padding().foregroundColor(.white)
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
                .onReceive(Just(PTS)) { newValue in
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
            HStack{
                Text("Count").font(.title2).fontWeight(.semibold).padding()
                Spacer()
                pickerView().padding()
            }
            
            
            
            Button(action: {
                armyControl.armies[armyID].mods[Unit.id]![modID].range = Range
                armyControl.armies[armyID].mods[Unit.id]![modID].name = Name
                armyControl.armies[armyID].mods[Unit.id]![modID].type = TypeM
                armyControl.armies[armyID].mods[Unit.id]![modID].pts = PTS
                armyControl.armies[armyID].mods[Unit.id]![modID].ap = AP
                armyControl.armies[armyID].mods[Unit.id]![modID].d = D
                armyControl.armies[armyID].mods[Unit.id]![modID].s = S
                armyControl.armies[armyID].mods[Unit.id]![modID].count = Count
            }){
                HStack{
                    Text("Save").foregroundColor(.white).font(.title2).fontWeight(.semibold).padding(.horizontal)
                }.padding(.horizontal).padding(.vertical, 7)
            }.background(RoundedRectangle(cornerRadius: 15).fill(.blue)).padding()
            
        }
            
        }.navigationTitle("Add a custom mod")
    }
}

extension addCustomMod {
    @ViewBuilder
    private func pickerView() -> some View {
        HStack {
            Button(action: {
                if (Count != 1){
                    Count = Count - 1
                                }
            }) {
                Text("-")
                    .font(.title2).fontWeight(.semibold).foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color(UIColor.systemGray2)))
            }
            Text("\(Count)")
            Button(action: {
                Count = Count + 1
            }) {
                Text("+")
                    .font(.title2).fontWeight(.semibold).foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color(UIColor.systemGray2)))
            }
        }
    }
}

struct addCustomMod_Previews: PreviewProvider {
    static var previews: some View {
        addCustomMod(armyID: 0, Unit: globalstats[0].units[0])
    }
}
