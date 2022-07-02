//
//  armyCustomization.swift
//  armybuilder
//
//  Created by ted on 6/27/22.
//

import SwiftUI

struct armyCustomization: View {
    @EnvironmentObject var armyControl: armyController
    @State var armyID: Int
    var body: some View {
        VStack{
            HStack{
                Text("Army name").font(.title2).fontWeight(.semibold)
                Spacer()
                TextField("", text:
                            $armyControl.armies[armyID].name).padding().foregroundColor(.white)
                    .frame(width: 150, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemGray2)))
            }.padding()
            VStack(){
                Button(action: {
                    /* army deletion... */
                }){
                    settingsitem(icon: "trash", optionname: "Delete army")
                }}

        
            Spacer()
        }.navigationTitle("Manage army")
    }
}

/*struct armyCustomization_Previews: PreviewProvider {
    static var previews: some View {
        armyCustomization(armyID: 0).environmentObject(armyController())
    }
}*/
