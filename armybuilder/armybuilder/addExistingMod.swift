import Combine
import SwiftUI

struct addExistingMod: View {  // View, через который происходит добавление готовой модификации
  @EnvironmentObject var armyControl: armyController
  @State var temppts = Int()
  @State var temptype = String()
  @State var armyID: Int
  @State var Unit: unit
  @State var Name = String()
  @State var Range = String()
  @State var TypeM = String()
  @State var S = String()
  @State var AP = Int()
  @State var D = String()
  @State var PTS = Int()
  @State var Count = 1
  @Environment(\.presentationMode) var presentationMode
  @State var mod: mod

  var body: some View {
    ScrollView {
      VStack {
        VStack {
          HStack {
            Text("Name").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField(
              "",
              text:
                $Name
            ).disabled(true).padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray4)))
          }.padding()

          HStack {
            Text("Range").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField(
              "",
              text:
                $Range
            ).disabled(true).padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray4)))
          }.padding()
          HStack {
            Text("Type").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField("", text: $TypeM).disabled(true).padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray4)))
          }.padding()
          HStack {
            Text("S").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField(
              "",
              text:
                $S
            ).disabled(true).padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray4)))
          }.padding()
          HStack {
            Text("AP").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField("", value: $AP, formatter: NumberFormatter())
              .keyboardType(.numberPad)
              .onReceive(Just(AP)) { newValue in
                let filtered = newValue
                if filtered != newValue {
                  AP = filtered
                }
              }.disabled(true).padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray4)))
          }.padding()
          HStack {
            Text("D").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField(
              "",
              text:
                $D
            ).disabled(true).padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray4)))
          }.padding()
          HStack {
            Text("Point cost").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField("", value: $PTS, formatter: NumberFormatter())
              .keyboardType(.numberPad)
              .onReceive(Just(PTS)) { newValue in
                let filtered = newValue
                if filtered != newValue {
                  if filtered >= 0 {
                    PTS = filtered
                  }
                }
              }.padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray6)))
          }.padding()
        }
        HStack {
          Text("Count").font(.title2).fontWeight(.semibold).padding()
          Spacer()
          pickerView().padding()
        }

        Button(action: {
          if PTS < 0 {
            PTS = 0
          }
          let mod = modification(
            name: Name, range: Range, type: TypeM, s: S, ap: AP, d: D, pts: PTS, count: Count)
          armyControl.armies[armyID].mods[Unit.id]!.append(mod)
          armyControl.armies[armyID].pointCount =
            armyControl.armies[armyID].pointCount + PTS * Count
          updatearmy(army: armyControl.armies[armyID])
          presentationMode.wrappedValue.dismiss()
        }) {
          HStack {
            Text("Save").foregroundColor(.white).font(.title2).fontWeight(.semibold).padding(
              .horizontal)
          }.padding(.horizontal).padding(.vertical, 7)
        }.background(RoundedRectangle(cornerRadius: 15).fill(.blue)).padding()

      }

    }.navigationTitle("Add a existing mod")
  }
}

extension addExistingMod {
  @ViewBuilder
  private func pickerView() -> some View {  // Маленький View с кнопками выбора количества модификаций
    HStack {
      Button(action: {
        if Count != 1 {
          Count = Count - 1
        }
      }) {
        Text("-")
          .font(.title2).fontWeight(.semibold).foregroundColor(.black)
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
          .background(RoundedRectangle(cornerRadius: 5).fill(Color(UIColor.systemGray6)))
      }
      Text("\(Count)")
      Button(action: {
        Count = Count + 1
      }) {
        Text("+")
          .font(.title2).fontWeight(.semibold).foregroundColor(.black)
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
          .background(RoundedRectangle(cornerRadius: 5).fill(Color(UIColor.systemGray6)))
      }
    }
  }
}
