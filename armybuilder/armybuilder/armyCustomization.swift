//
//  armyCustomization.swift
//  armybuilder
//
//  Created by ted on 6/27/22.
//

import SwiftUI

struct armyCustomization: View {
  @EnvironmentObject var armyControl: armyController
  @State var armyID: Int
  @State var sameNameWarn = false
  @State var emptyNameWarn = false
  @State var longNameWarn = false
  @State var savedAlert = false
  @State var temparmyName = String()
  var body: some View {
    VStack {
        HStack {
          Text("Manage army").font(.largeTitle).fontWeight(.semibold)
          Spacer()
        }.padding()
      if sameNameWarn == true {
        Text("You already have an army with that name.").foregroundColor(.red).fontWeight(.semibold)
      } else if emptyNameWarn == true {
          Text("You can't create an army with an empty name.").foregroundColor(.red).fontWeight(.semibold)
      } else if longNameWarn == true {
          Text("You can't create an army with such a long name.").foregroundColor(.red).fontWeight(.semibold)
      } else if savedAlert == true {
          Text("Army name saved.").foregroundColor(.green).fontWeight(.semibold)
      } else {
          Text(" ")
      }
      HStack {
        Text("Army name").font(.title2).fontWeight(.semibold)
        Spacer()
        TextField(
          "",
          text:
            $temparmyName
        ).padding().foregroundColor(.black)
          .frame(width: 150, height: 10)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 8)
              .fill(Color(UIColor.systemGray6)))
      }.padding(20)

      Spacer()
    }.toolbar {
      ToolbarItemGroup(placement: .primaryAction) {
        Button(action: {
          if sameNameCheck == false {
              if (!temparmyName.trimmingCharacters(in: .whitespaces).isEmpty){
                  if (temparmyName.count <= 64){
                      changearmyname(oldname: armyControl.armies[armyID].name, newname: temparmyName)
                      armyControl.armies[armyID].name = temparmyName
                      longNameWarn = false
                      sameNameWarn = false
                      emptyNameWarn = false
                      savedAlert = true
                  } else {
                      longNameWarn = true
                      sameNameWarn = false
                      emptyNameWarn = false
                  }
              } else {
                  emptyNameWarn = true
                  longNameWarn = false
                  sameNameWarn = false
              }
          } else {
              sameNameWarn = true
              longNameWarn = false
              emptyNameWarn = false
          }
        }) {
          Text("Save")
        }
      }
    }
  }
    var sameNameCheck:Bool{
        for army in armyControl.armies {
          if army.name == temparmyName {
            return true
          }
        }
        return false
    }
}
