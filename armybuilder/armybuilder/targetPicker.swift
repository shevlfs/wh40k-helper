//
//  targetPicker.swift
//  armybuilder
//
//  Created by ted on 6/14/22.
//

import SwiftUI
import Combine

struct targetPicker: View {
    @StateObject var targetPoints: pointTarget

    var body: some View {
        VStack{
        TextField("Target number of points", value: $targetPoints.count, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .onReceive(Just(targetPoints.count)) { newValue in
                let filtered = newValue
                if filtered != newValue {
                    targetPoints.count = filtered
                    
       
                }
                }
            Text("\(targetPoints.count)")
        }.environmentObject(targetPoints)
    }
}

struct targetPicker_Previews: PreviewProvider {
    static var previews: some View {
        targetPicker(targetPoints: pointTarget())
    }
}
