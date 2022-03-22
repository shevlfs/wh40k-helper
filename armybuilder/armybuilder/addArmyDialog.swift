//
//  addArmyDialog.swift
//  armybuilder
//
//  Created by ted on 3/21/22.
//

import SwiftUI

struct addArmyDialog: View {
    @State var factionSelected = false
    var body: some View {
        VStack(alignment: .center){
        VStack(alignment: .leading){
            HStack(){
                VStack(alignment: .leading){
                    Text("Add a new army!").font(.title).fontWeight(.bold).padding(.horizontal)
                    Text("Select your faction ").fontWeight(.regular).padding([.leading, .bottom, .trailing]).font(.title3)
                }
                Spacer()
            }.padding(.top, 20)

            Spacer()
        }.padding(.top).frame(width: 400, height: 130, alignment: .center)
            VStack(alignment: .center){
                ScrollView(.vertical){
                ForEach(factions){faction in
                    Button(action:{}){
                        ZStack(){
                            Rectangle().fill(Color(UIColor.systemGray4)).frame(width: 370.0, height: 55.0).cornerRadius(10).padding(.all,10.0)
                            Text(faction.name)
                                .font(.headline)
                            .foregroundColor(Color.black)}
                    }
                }
                        
            }
                Spacer()
                
            }
        }
    }
}

struct addArmyDialog_Previews: PreviewProvider {
    static var previews: some View {
        addArmyDialog()
    }
}
