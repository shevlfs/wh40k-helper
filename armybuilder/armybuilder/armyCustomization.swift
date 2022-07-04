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
    @State var sameNameWarn = false
    @State var temparmyName = String()
    var body: some View {
        VStack{
            if (sameNameWarn == true){
            Text("You already have an army with that name.").foregroundColor(.red).fontWeight(.semibold)
            }
            HStack{
                Text("Army name").font(.title2).fontWeight(.semibold)
                Spacer()
                TextField("", text:
                            $temparmyName).padding().foregroundColor(.white)
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
        }.navigationTitle("Manage army").toolbar{
            ToolbarItemGroup(placement: .primaryAction){
                Button(action: {
                    
                    for army in armyControl.armies{
                        if (army.name == temparmyName){
                            sameNameWarn = true
                        }
                    }
                    if (sameNameWarn == false){
                        armyControl.armies[armyID].name = temparmyName
                    }
                    
                }){
                    Text("Save")
                }
            }
        }
    }
}

/*struct armyCustomization_Previews: PreviewProvider {
    static var previews: some View {
        armyCustomization(armyID: 0).environmentObject(armyController())
    }
}*/


func getName(armyControl: armyController, id: Int)->String{
    return armyControl.armies[id].name
}
