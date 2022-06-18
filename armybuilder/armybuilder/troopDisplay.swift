//
//  troopDisplay.swift
//  armybuilder
//
//  Created by ted on 6/18/22.
//

import SwiftUI

struct troopDisplay: View {
    @State var unitcount: Int
    @State var unitname = String()
    @State var pointcount = Int()
    @EnvironmentObject var pointTarget: pointTarget
    @EnvironmentObject var armyControl: armyController
    var body: some View {
        VStack(alignment: .trailing) {
            Text(unitname)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.teal)
                )
            pickerView()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
    }
}

extension troopDisplay {
    @ViewBuilder
    private func pickerView() -> some View {
        HStack {
            Text("\(pointcount) pts").foregroundColor(.white)
                .padding(.vertical, 8).padding(.horizontal, 40)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.teal))
                
            Spacer()
             
                
            
            Text("\(unitcount)").foregroundColor(.white)
                .padding(.vertical, 8).padding(.horizontal, 40)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.teal))
        }
    }
}


struct troopDisplay_Previews: PreviewProvider {
    static var previews: some View {
        troopDisplay(unitcount: 0)
    }
}
