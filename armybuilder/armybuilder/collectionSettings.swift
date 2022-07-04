//
//  collectionSettings.swift
//  armybuilder
//
//  Created by ted on 6/13/22.
//

import SwiftUI

struct collectionSettings: View {
    @State var factionSelected = false
    @EnvironmentObject var collectionDatas: collectionData
    var body: some View {
        
        
    ScrollView(.vertical){
        VStack(){
            HStack(){
                    Text("Choose the faction of your units ").fontWeight(.regular).padding([.leading, .bottom, .trailing],14).font(.title3)
            }
            VStack(alignment: .center){
                ForEach(factions){faction in
                    NavigationLink(destination: collectionAddUnits(factionfile: faction.id).environmentObject(collectionDatas).onDisappear(perform: {
                        
                        saveCollection(collectionDatas: collectionDatas)
                        
                        
                        
                    })){
                        ZStack(){
                            Rectangle().fill(Color(UIColor.systemGray4)).frame(width: 370.0, height: 55).cornerRadius(10).padding(.all,10.0)
                            Text(faction.name)
                                .font(.headline)
                            .foregroundColor(Color.black)}
                    }
                }
                        
            }
                
                
            }
    }.navigationTitle("Add units to collection").navigationViewStyle(.stack)
    }
}



struct collectionSettings_Previews: PreviewProvider {
    static var previews: some View {
        collectionSettings()
    }
}
