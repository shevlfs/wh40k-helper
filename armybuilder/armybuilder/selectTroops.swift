//
//  selectTroops.swift
//  armybuilder
//
//  Created by ted on 3/23/22.
//

import SwiftUI

struct selectTroops: View {
    @State var factionfile = Int()
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
        VStack(alignment: .center){
        VStack(alignment: .leading){
            HStack(){
                    Text("Select troops for your army ").fontWeight(.regular).padding([.leading, .bottom, .trailing],14).font(.title3)
                Spacer()
            }

            Spacer()
        }.navigationTitle("Add a new army!").padding([.top,.bottom]).frame(width: 400,height:50,alignment: .center)
            VStack(alignment: .center){
                ForEach(globalstats[factionfile].units){unit in
                    ZStack(){
                        Rectangle().fill(Color(UIColor.systemTeal)).frame(width: 370.0, height: 55.0).cornerRadius(10).padding(.all,10.0)
                        Text(unit.name)
                            .foregroundColor(Color.white).fontWeight(.bold).font(.headline)
                    }
                }
                }
            }
        }
        }.navigationBarHidden(true)
}
}

struct selectTroops_Previews: PreviewProvider {
    static var previews: some View {
        selectTroops()
    }
}
