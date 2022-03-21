//
//  armyDetailedView.swift
//  armybuilder
//
//  Created by ted on 24.02.2022.
//

import SwiftUI

struct armyDetailedView: View {
    @StateObject var army = Army()
    @State var id = Int()
    @State var editMode = false
    
    var body: some View {
            VStack(){
                
                VStack{
                    HStack(){
                        VStack(alignment: .leading){
                    Text("Faction: \(army.faction)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Text("Points: \(army.points)")
                        .font(.title3)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        }.padding(.bottom)
                        Spacer()
    
                    }.padding([.leading, .bottom, .trailing], 19.0)
                    Spacer()
                    
                }
            
                
        }.navigationTitle("Army \(id)").toolbar {
            ToolbarItemGroup(placement: .primaryAction){
                Button(action: {
                    self.editMode.toggle()
                }) {
                    Label("Add",systemImage:"pencil")}.sheet(isPresented: $editMode){
                        editArmy()
                    }

            }
    }
}

struct armyDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        armyDetailedView()
    }
}
}
