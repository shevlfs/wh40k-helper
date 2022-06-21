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
                HStack{
                    VStack{
                        Text("M").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.m)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        
                    }
                    VStack{
                        Text("WS").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.ws)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        
                    }
                    VStack{
                        Text("BS").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.bs)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        
                    }
                    VStack{
                        Text("S").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.s)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        
                    }
                    VStack{
                        Text("T").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.t)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        
                    }
                    VStack{
                        Text("W").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.w)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        
                    }
                    VStack{
                        Text("A").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.a)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        
                    }
                    VStack{
                        Text("Ld").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.ld)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        
                    }
                    VStack{
                        Text("Sv").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        Text("\(Unit.sv)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(4)
                        
                    }
                    
                }
                
                
            }.padding()
        }.background(RoundedRectangle(cornerRadius: 13).fill(.green).blur(radius: 1))
    }
}

struct unitStats_Previews: PreviewProvider {
    static var previews: some View {
        unitStats(Unit: globalstats[0].units[0])
    }
}
