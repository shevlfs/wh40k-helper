//
//  TableHeader.swift
//  armybuilder
//
//  Created by ted on 6/23/22.
//

import SwiftUI

struct TableHeader: View { // View с "заголовком" таблицы статистик юнитов в "режиме игры" при отображении всей армии
  var body: some View {
    HStack {
      HStack(alignment: .center, spacing: nil) {
        Group {
          Text("M").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
            maxWidth: 50, alignment: .leading)
          Text("WS").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
            maxWidth: 50, alignment: .leading)
          Text("BS").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
            maxWidth: 50, alignment: .leading)
          Text("S").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
            maxWidth: 50, alignment: .leading)
          Text("T").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
            maxWidth: 50, alignment: .leading)
          Text("W").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
            maxWidth: 50, alignment: .leading)
          Text("A").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
            maxWidth: 50, alignment: .leading)
          Text("Ld").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
            maxWidth: 50, alignment: .leading)
          Text("Sv").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
            maxWidth: 50, alignment: .leading)
        }

      }.padding()
    }.background(RoundedRectangle(cornerRadius: 10).fill(.green)).padding()
  }
}
