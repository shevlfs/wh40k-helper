//
//  targetPicker.swift
//  armybuilder
//
//  Created by ted on 6/14/22.
//

import Combine
import SwiftUI

struct targetPicker: View { // View, который отображает настройки цели по очкам
  @EnvironmentObject var pointTarget: pointTarget

  var body: some View {
    VStack {
      Toggle("Point target", isOn: $pointTarget.isPointTargetOn).padding().foregroundColor(.black)
      Text("Select target number of points:").foregroundColor(.black)
      TextField("", value: $pointTarget.pointTargetCount, formatter: NumberFormatter())
        .keyboardType(.numberPad)
        .onReceive(Just(pointTarget.pointTargetCount)) { newValue in
          let filtered = newValue
          if filtered != newValue {
            pointTarget.pointTargetCount = filtered
          }
        }.padding().foregroundColor(.white)
        .frame(width: 150, height: 10)
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(pointTarget.isPointTargetOn ? Color(UIColor.systemGray3):Color(UIColor.systemGray6))
        ).disabled(!pointTarget.isPointTargetOn)
    }.padding()
  }
}

struct targetPicker_Previews: PreviewProvider {
  static var previews: some View {
    targetPicker().environmentObject(pointTarget())
  }
}
