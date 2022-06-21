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
                        Group{
                        Text("M").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("WS").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("BS").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("S").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("T").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("W").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("A").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("Ld").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("Sv").fontWeight(.bold).foregroundColor(.white).padding(4)
                        }
                    }
                    HStack{
                        Group{
                            Text("\(Unit.m)").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.ws)").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.bs)").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.s)").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.t)").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.w)").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.a)").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.ld)").fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.sv)").fontWeight(.bold).foregroundColor(.white).padding(4)
                        }
                    }
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
