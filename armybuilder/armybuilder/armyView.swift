//
//  armyView.swift
//  armybuilder
//
//  Created by ted on 21.02.2022.
//

import SwiftUI

struct armyView: View { // View для отображения армий в главном меню
  @State var id = Int()
  @State var faction = String()
  @EnvironmentObject var collectionDatas: collectionData
  @EnvironmentObject var armyControl: armyController
  var body: some View {
    if checkForSafety(armyID: id, armyControl: armyControl) {
      VStack {
        Group {
          VStack(alignment: .center, spacing: 4) {
            HStack {
              Spacer()
              Text("\(armyControl.armies[id-1].name)")
                .font(.title)
                .foregroundColor(.white)
                .bold()
              Spacer()
            }
            HStack {
              Text("\(armyControl.armies[id-1].pointCount) pts")
              Rectangle()
                .frame(width: 0.5, height: 20)
              HStack(spacing: 6) {
                Image(systemName: "bolt.horizontal.fill")
                Text("\(faction)" + " ")
              }
            }.foregroundColor(.white)
          }
          .padding(.vertical, 48)
          .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
              .fill(Color(UIColor.systemGreen))

          )
          .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
              .fill(Color(UIColor.systemGreen))
              .blur(radius: 10)

          )
          .padding(32)
        }
        .buttonStyle(ScaleableButtonStyle())
      }

    } else {
      EmptyView()
    }

  }
}

struct ScaleableButtonStyle: ButtonStyle { // Реализация эффекта "сжимания" при нажатии на армию
  func makeBody(configuration: Configuration) -> some View {
    return configuration.label
      .scaleEffect(configuration.isPressed ? 0.98 : 1)
      .animation(.interactiveSpring(), value: configuration.isPressed)
  }
}

func checkForSafety(armyID: Int, armyControl: armyController) -> Bool {  // проверка на безопасность вывода армии после удаления
  if armyControl.armies.count <= armyID - 1 {
    return false
  }
  return true
}
