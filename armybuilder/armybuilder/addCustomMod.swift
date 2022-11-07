import Combine
import SwiftUI

struct addCustomMod: View { // View, через который происходит добавление модификации вручным вводом характеристик и статистики
  @EnvironmentObject var armyControl: armyController
  @State var temppts = Int()
  @State var temptype = String()
  @State var armyID: Int
  @State var Unit: unit
  @Environment(\.presentationMode) var presentationMode
  let dLimit = 3
  let sLimit = 2
  let nameLimit = 20
  let typeLimit = 9
  let rangeLimit = 3
  @State var emptyWarn = false
  @State var Name = String()
  @State var Range = String()
  @State var TypeM = String()
  @State var S = String()
  @State var AP = Int()
  @State var D = String()
  @State var PTS = Int()
  @State var Count = 1
  var body: some View {
    ScrollView {
      VStack {
          Text("Fields cannot be empty.").foregroundColor(.red).opacity(emptyWarn ? 1 : 0)
          HStack {
            Text("Name").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField(
              "",
              text:
                $Name
            ).onReceive(Just(Name)) { _ in limitNameText(nameLimit)}.padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray6)))
          }.padding()
          

          HStack {
            Text("Range").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField(
              "",
              text:
                $Range
            ).onReceive(Just(Range)) { _ in limitRangeText(rangeLimit)}.padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray6)))
          }.padding()
          HStack {
            Text("Type").font(.title2).fontWeight(.semibold)
            Spacer()
              TextField("", text: $TypeM).onReceive(Just(TypeM)) { _ in limitTypeText(typeLimit)}.padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray6)))
          }.padding()
          HStack {
            Text("S").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField(
              "",
              text:
                $S
            ).onReceive(Just(S)) { _ in limitSText(sLimit) }.padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray6)))
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
              }.padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray6)))
          }.padding()
          HStack {
            Text("D").font(.title2).fontWeight(.semibold)
            Spacer()
            TextField(
              "",
              text:
                $D
            ).onReceive(Just(D)) { _ in limitDText(dLimit) }.padding().foregroundColor(.black)
              .frame(width: 150, height: 10)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray6)))
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
            
            if (!Name.trimmingCharacters(in: .whitespaces).isEmpty && !TypeM.trimmingCharacters(in: .whitespaces).isEmpty && !Range.trimmingCharacters(in: .whitespaces).isEmpty &&
                !D.trimmingCharacters(in: .whitespaces).isEmpty && !S.trimmingCharacters(in: .whitespaces).isEmpty){
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
                
            } else {
                emptyWarn = true
            }
            
        }) {
          HStack {
            Text("Save").foregroundColor(.white).font(.title2).fontWeight(.semibold).padding(
              .horizontal)
          }.padding(.horizontal).padding(.vertical, 7)
        }.background(RoundedRectangle(cornerRadius: 15).fill(.blue)).padding()
    }.navigationTitle("Add a custom mod")
  }
    // далее идут функции, которые ограничивают размер текста, который можно ввести в полях при создании собственной модификации
    func limitNameText(_ upper: Int) { // функция ограничивающая размер имени модификации
            if Name.count > upper {
                Name = String(Name.prefix(upper))
            }
        }
    func limitDText(_ upper: Int) { // функция ограничивающая размер характеристики D модификации
            if D.count > upper {
                D = String(D.prefix(upper))
            }
        }
    func limitSText(_ upper: Int) { // функция ограничивающая характеристики S модификации
            if S.count > upper {
                S = String(S.prefix(upper))
            }
        }
    func limitTypeText(_ upper: Int) { // функция ограничивающая размер типа модификации
            if TypeM.count > upper {
                TypeM = String(TypeM.prefix(upper))
            }
        }
    func limitRangeText(_ upper: Int) { // функция ограничивающая размер характеристики Range модифицации
            if Range.count > upper {
                Range = String(Range.prefix(upper))
            }
        }
}

extension addCustomMod {
  @ViewBuilder
  private func pickerView() -> some View { // Маленький View с кнопками выбора количества модификаций
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
