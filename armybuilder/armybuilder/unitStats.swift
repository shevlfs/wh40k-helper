//
//  unitStats.swift
//  armybuilder
//
//  Created by ted on 6/21/22.
//

import SwiftUI

struct unitStats: View {
    @State var Unit: unit
    var body: some View {
        VStack{
            Group{
                VStack{
                    HStack{
                        Text("M").fontWeight(.bold).foregroundColor(.white).padding(.leading)
                        Text("WS").fontWeight(.bold).foregroundColor(.white)
                        Text("BS").fontWeight(.bold).foregroundColor(.white)
                        Text("S").fontWeight(.bold).foregroundColor(.white)
                        Text("T").fontWeight(.bold).foregroundColor(.white)
                        Text("W").fontWeight(.bold).foregroundColor(.white)
                        Text("A").fontWeight(.bold).foregroundColor(.white)
                        Text("Ld").fontWeight(.bold).foregroundColor(.white)
                        Text("Sv").fontWeight(.bold).foregroundColor(.white).padding(.trailing)
                        
                    }.padding(.vertical)
                    HStack{
                        
                    }.padding(.vertical)
                }
                
                
            }.background(RoundedRectangle(cornerRadius: 10).fill(.green).blur(radius: 1)).padding()
        }
    }
}

struct unitStats_Previews: PreviewProvider {
    static var previews: some View {
        unitStats(Unit: globalstats[0].units[0])
    }
}
