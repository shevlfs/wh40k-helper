//
//  TableHeader.swift
//  armybuilder
//
//  Created by ted on 6/23/22.
//

import SwiftUI

struct tableUnitHeader: View {
  @State var name = String()
  var body: some View {
    HStack {
      HStack {
        HStack(alignment: .center, spacing: nil) {
          Group {
            Text("Range").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 80, alignment: .center)
            Text("Type").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 120, alignment: .center)
            Text("S").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center)
            Text("AP").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center)
            Text("D").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 90, alignment: .center)

          }.padding()
        }.background(RoundedRectangle(cornerRadius: 10).fill(.mint)).padding()
      }
      Spacer()
      Text("\(name)").fontWeight(.bold).multilineTextAlignment(.center).foregroundColor(.black)
        .font(.title2).frame(maxWidth: 215, alignment: .trailing)

    }
  }
}

struct tableUnitHeader_previews: PreviewProvider {
  static var previews: some View {
    tableUnitHeader()
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
