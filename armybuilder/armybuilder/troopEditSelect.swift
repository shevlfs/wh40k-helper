import SwiftUI

struct troopEditSelect: View { // View для отображения конкретного юнита при изменении армии
  @State var unitcount: Int
  @State var unitname = String()
  @State var pointcount = Int()
  @State var unit: unit
  @State var armyID: Int
  @EnvironmentObject var pointTarget: pointTarget
  @EnvironmentObject var armyControl: armyController
  @EnvironmentObject var collectionDatas: collectionData
  var body: some View {
    VStack(alignment: .trailing) {
      NavigationLink(
        destination: troopDetailedView(Unit: unit, factionID: armyControl.armies[armyID].factionID)
          .environmentObject(collectionDatas)
      ) {
        Text(unitname)
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(.teal)
          )
      }
      pickerView()
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
  }
}

extension troopEditSelect {
  @ViewBuilder
  private func pickerView() -> some View { // Маленький View отображающий кнопки + и - для добавления или удаления юнита, количество этого юнита и его цену в очках
    HStack {
      Text("\(pointcount) pts").foregroundColor(.white)
        .padding(.vertical, 8).padding(.horizontal, 40)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(.teal)
        )
      Spacer()
      Button(action: {
        if armyControl.armies[armyID].troops[unit.id]! == 1 {
          if armyControl.armies[armyID].mods[unit.id]!.isEmpty == false {
            for mod in armyControl.armies[armyID].mods[unit.id]! {
              armyControl.armies[armyID].pointCount -= (mod.pts * mod.count)
            }
            armyControl.armies[armyID].mods[unit.id] = [modification]()

          }
          armyControl.armies[armyID].pointCount -= pointcount
          armyControl.armies[armyID].troops[unit.id]! -= 1
        } else if armyControl.armies[armyID].troops[unit.id]! != 0 {
          armyControl.armies[armyID].pointCount -= pointcount
          armyControl.armies[armyID].troops[unit.id]! -= 1
        }
      }) {
        Text("-")
          .foregroundColor(.white)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
      }
      Text("\(armyControl.armies[armyID].troops[unit.id]!)")
      Button(action: {
        armyControl.armies[armyID].pointCount += pointcount
        armyControl.armies[armyID].troops[unit.id]! += 1
      }) {
        Text("+")
          .foregroundColor(.white)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
      }
    }
  }
}
