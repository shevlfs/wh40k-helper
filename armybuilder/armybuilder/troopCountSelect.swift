//
//  troopCountSelect.swift
//  armybuilder
//
//  Created by ted on 3/24/22.
//

import SwiftUI

struct troopCountSelect: View {
    @State var unitcount = 0
    @State var unitname = String()
    var body: some View {
        ZStack{
            Rectangle().fill(Color(UIColor.systemGray6)).frame(width: 400.0, height: 145.0).cornerRadius(10).padding(.all,10.0)
            
        VStack(alignment: .center){
            VStack(alignment: .center){
                
                    ZStack(){
                        Rectangle().fill(Color(UIColor.systemTeal)).frame(width: 370.0, height: 55.0).cornerRadius(10).padding(.all,10.0)
                        Text("\(unitname)")
                            .foregroundColor(Color.white).fontWeight(.bold).font(.headline)

                }
                
            }
            HStack(){
                Spacer()
                Button(action:{}){
                ZStack(){
                    Rectangle().fill(Color(UIColor.systemTeal)).frame(width: 25.0, height: 25.0).cornerRadius(5).padding(.all,10.0)
                    Text("-")
                        .foregroundColor(Color.white).fontWeight(.bold).font(.headline)
            }
                }
                Text("\(unitcount)")
                Button(action: {}){
                ZStack(){
                    Rectangle().fill(Color(UIColor.systemTeal)).frame(width: 25.0, height: 25.0).cornerRadius(5).padding(.all,10.0)
                    Text("+")
                        .foregroundColor(Color.white).fontWeight(.bold).font(.headline)
                }
            }}.ignoresSafeArea().offset(x: -20, y: -10)
            }
        }
    }
}

struct troopCountSelect_Previews: PreviewProvider {
    static var previews: some View {
        troopCountSelect()
    }
}
