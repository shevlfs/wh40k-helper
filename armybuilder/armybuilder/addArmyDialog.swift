//
//  addArmyDialog.swift
//  armybuilder
//
//  Created by ted on 3/21/22.
//

import SwiftUI

struct addArmyDialog: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                VStack(alignment: .leading){
                Text("Add a new army!").font(.title).fontWeight(.bold).padding()
                    Text("Select your faction ").fontWeight(.regular).padding([.leading, .bottom, .trailing]).font(.title3)
                }
                Spacer()
            }.padding(.top, 20)
            
            Spacer()
        }
    }
}

struct addArmyDialog_Previews: PreviewProvider {
    static var previews: some View {
        addArmyDialog()
    }
}
