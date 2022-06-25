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
    var body: some View {
        NavigationView{
        VStack{
        ScrollView{
            HStack{
                NavigationLink(destination: addCustomMod(armyID: armyID, Unit: Unit).environmentObject(armyControl)){
                    Text("Add custom...")
                        .font(.title2)
                        .fontWeight(.semibold)
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
        addUnitMods(armyID: 0).environmentObject(armyController())
    }
}
