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
            List{
                ForEach(armyControl.getNames()){
                    army in Text(army.name)
                }
            }.navigationTitle("Delete armies")

}
    func deleteArmy(at offsets: IndexSet){
        print("")
    }
}

struct armyDeletion_Previews: PreviewProvider {
    static var previews: some View {
        armyDeletion()
    }
}
