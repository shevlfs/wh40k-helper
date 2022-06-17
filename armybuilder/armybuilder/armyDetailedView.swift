//
//  armyDetailedView.swift
//  armybuilder
//
//  Created by ted on 24.02.2022.
//

import SwiftUI

struct armyDetailedView: View {
    @State var id = Int()
    @State var editMode = false
    
    var body: some View {
            VStack(){
                
                VStack{
                    HStack(){
                        ZStack{
                            Rectangle().fill(Color(UIColor.systemGray3))
                            .frame(width: 190, height: 70, alignment: .leading).cornerRadius(15)
                        VStack(alignment: .leading){
                            
                    Text("Faction: fdf")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Text("Points: dsaf")
                        .font(.title3)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        }}
                        Spacer()
    
                    }.padding([.leading, .bottom, .trailing], 19.0)
                    Spacer()
                    
                    }
                .frame(width: 415.0, height: 90.0)
                Spacer()
                VStack(){
                    Text("Troop Name")
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
