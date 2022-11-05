//
//  rectangleLogo.swift
//  armybuilder
//
//  Created by ted on 6/29/22.
//

import SwiftUI

struct rectangleLogo: View {  // View с логотипом приложения
  @State var gradient = [Color.indigo, Color.mint, Color.green]
  @State var startPoint = UnitPoint(x: 0, y: 0)
  @State var endPoint = UnitPoint(x: 0, y: 2)
  var body: some View {
    RoundedRectangle(cornerRadius: 15)
      .fill(
        LinearGradient(
          gradient: Gradient(colors: self.gradient), startPoint: self.startPoint,
          endPoint: self.endPoint)
      ).blur(radius: 3)
      .frame(width: 250, height: 150)
      .onAppear {
        DispatchQueue.main.async {
          withAnimation(.easeInOut(duration: 10.0).repeatForever(autoreverses: true)) {
            self.startPoint = UnitPoint(x: 1, y: -1)
            self.endPoint = UnitPoint(x: 0, y: 1)
          }

        }
      }
  }
}

struct rectangleLogo_Previews: PreviewProvider {
  static var previews: some View {
    rectangleLogo()
  }
}
