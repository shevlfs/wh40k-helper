//
//  modGameView.swift
//  armybuilder
//
//  Created by ted on 6/28/22.
//

import SwiftUI

struct modGameView: View {
  @State var id = Int()
  @State var mod: modification
  var body: some View {
    HStack {
      HStack {
        HStack(alignment: .center, spacing: nil) {
          Group {
            Text("\(mod.range)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
                maxWidth: 75, alignment: .center).lineLimit(1).minimumScaleFactor(0.01)
            Text("\(mod.type)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 130, alignment: .center
            ).lineLimit(1).minimumScaleFactor(0.01)
            Text("\(mod.s)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center).lineLimit(1).minimumScaleFactor(0.01)
            Text("\(mod.ap)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center).lineLimit(1).minimumScaleFactor(0.01)
            Text("\(mod.d)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 75, alignment: .center).lineLimit(1).minimumScaleFactor(0.01)

          }.padding()
        }.background(RoundedRectangle(cornerRadius: 10).fill(.mint)).padding()
      }
      Spacer()
        Text("\(mod.name)").fontWeight(.bold).multilineTextAlignment(.trailing).foregroundColor(.black)
            .font(.title2).frame(maxWidth: 120, alignment: .trailing).lineLimit(3).scaledToFit().minimumScaleFactor(0.01)
    }
  }
}

struct modGameView_Previews: PreviewProvider {
  static var previews: some View {
    modGameView(
      id: 0,
      mod: modification(name: "asd", range: "", type: "", s: "", ap: 0, d: "", pts: 0, count: 0)
    )
  }
}
