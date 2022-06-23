//
//  addUnitMods.swift
//  armybuilder
//
//  Created by ted on 6/23/22.
//

import SwiftUI

struct addUnitMods: View {
    @EnvironmentObject var armyControl: armyController
    var body: some View {
        NavigationView{
        VStack{
        ScrollView{
            ForEach(mods){
                mod in modDisplay(mod:mod)
            }
        }
        }.navigationTitle("Add modifications")
        }
    }
}

struct addUnitMods_Previews: PreviewProvider {
    static var previews: some View {
        addUnitMods().environmentObject(armyController())
    }
}
