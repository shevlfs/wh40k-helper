//
//  troopCountSelect.swift
//  armybuilder
//
//  Created by ted on 3/24/22.
//

import SwiftUI

struct troopCountSelect: View {
    @Binding var unitcount: Int
    @State var unitname = String()
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

extension troopCountSelect {
    @ViewBuilder
    private func pickerView() -> some View {
        HStack {
            Button(action: {
                unitcount -= 1
            }) {
                Text("-")
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
            }
            Text("\(unitcount)")
            Button(action: {
                unitcount += 1
            }) {
                Text("+")
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
            }
        }
    }
}

struct troopCountSelect_Previews: PreviewProvider {
    static var previews: some View {
        troopCountSelect(unitcount: .constant(0), unitname: "gogas")
    }
}
