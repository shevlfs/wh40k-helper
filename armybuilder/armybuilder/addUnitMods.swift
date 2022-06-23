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
        VStack{
        ScrollView{
            ForEach(mods){
                mod in Text("\(mod.name)")
            }
        }
        }
    }
}

struct addUnitMods_Previews: PreviewProvider {
    static var previews: some View {
        addUnitMods().environmentObject(armyController())
    }
}
