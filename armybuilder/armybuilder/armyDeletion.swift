//
//  armyDeletion.swift
//  armybuilder
//
//  Created by ted on 6/27/22.
//

import SwiftUI

struct armyDeletion: View {
    @EnvironmentObject var armyControl: armyController
    var body: some View {
        ScrollView{
            List{
                ForEach(armyControl.armies){
                    army in Text("\(army.name)")
                }
            }
        }.navigationTitle("Delete armies")
    }
}

struct armyDeletion_Previews: PreviewProvider {
    static var previews: some View {
        armyDeletion()
    }
}
