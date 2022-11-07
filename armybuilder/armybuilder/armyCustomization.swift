import SwiftUI
import Combine

struct armyCustomization: View { // View с настройками армии
  @EnvironmentObject var armyControl: armyController
  @State var armyID: Int
  @State var sameNameWarn = false
  @State var emptyNameWarn = false
  @State var longNameWarn = false
  @State var savedAlert = false
  @State var temparmyName = String()
  let nameLimit = 36
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
        ).onReceive(Just(temparmyName)) { _ in limitNameText(nameLimit) }.padding().foregroundColor(.black)
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
                      changearmyname(oldname: armyControl.armies[armyID].name, newname: temparmyName)
                      armyControl.armies[armyID].name = temparmyName
                      sameNameWarn = false
                      emptyNameWarn = false
                      savedAlert = true
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
    var sameNameCheck:Bool{ // Проверка на наличие армий с таким же названием (при изменении имени армии)
        for army in armyControl.armies {
          if army.name == temparmyName {
            return true
          }
        }
        return false
    }
    func limitNameText(_ upper: Int) { // функция ограничивающая размер имени армии
            if temparmyName.count > upper {
                temparmyName = String(temparmyName.prefix(upper))
            }
        }
}
