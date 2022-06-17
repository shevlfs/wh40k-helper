//
//  targetPicker.swift
//  armybuilder
//
//  Created by ted on 6/14/22.
//

import SwiftUI
import Combine

struct targetPicker: View {
    @EnvironmentObject var pointTarget: pointTarget

    var body: some View {
        VStack{
            Toggle("Point target", isOn: $pointTarget.targetpointbool).padding().foregroundColor(.black)
            Text("Select target number of points:").foregroundColor(.black)
        TextField("", value: $pointTarget.count, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .onReceive(Just(pointTarget.count)) { newValue in
                let filtered = newValue
                if filtered != newValue {
                    pointTarget.count = filtered
                }
            }.padding().foregroundColor(.white)
                .frame(width: 150, height: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray2))).disabled(!pointTarget.targetpointbool)
        }.padding()
    }
}

struct targetPicker_Previews: PreviewProvider {
    static var previews: some View {
        targetPicker().environmentObject(pointTarget())
    }
}
