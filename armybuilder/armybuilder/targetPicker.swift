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
        TextField("Target number of points", value: $pointTarget.count, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .onReceive(Just(pointTarget.count)) { newValue in
                let filtered = newValue
                if filtered != newValue {
                    pointTarget.count = filtered
                    
       
                }
                }
            Text("\(pointTarget.count)")
        }
    }
}

struct targetPicker_Previews: PreviewProvider {
    static var previews: some View {
        targetPicker().environmentObject(pointTarget())
    }
}
