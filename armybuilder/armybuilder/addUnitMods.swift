//
//  addUnitMods.swift
//  armybuilder
//
//  Created by ted on 6/23/22.
//

import SwiftUI

struct addUnitMods: View {
    @EnvironmentObject var armyControl: armyController
    @State var searchBarMods = [String]()
    @State var armyID: Int
    @State private var searchText = ""
    @State var Unit: unit
    @State var addMod: Bool? = nil
    @State var modID = Int()
    var body: some View {
        NavigationView{
        VStack{
        ScrollView{
            HStack{
                NavigationLink(destination: addCustomMod(armyID: armyID, modID: modID, Unit: Unit
                                                        
                                                        
                            ).environmentObject(armyControl), tag: true, selection: $addMod){EmptyView()
                }
                Text("Add custom...")
                    .font(.title2).foregroundColor(.blue)
                    .fontWeight(.semibold).onTapGesture {
                        self.addMod = true
                    }
            }.padding()
                ForEach(searchResults){
                    mod in modDisplay(mod: mod)
                }.searchable(text: $searchText)
        }
        }.navigationTitle("Add modifications")
        }
    }
    var searchResults: [mod] {
            if searchText.isEmpty {
                return mods
            } else {
                return mods.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
    }





struct addUnitMods_Previews: PreviewProvider {
    static var previews: some View {
        addUnitMods(armyID: 0, Unit: globalstats[0].units[0], modID: 0).environmentObject(armyController())
    }
}
