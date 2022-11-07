import SwiftUI

struct troopCountSelect: View {  // View для отображения конкретного юнита при создании армии
  @State var unitcount: Int
  @State var unitname = String()
  @State var pointcount = Int()
  @State var unit: unit
  @State var faction: Int
  @EnvironmentObject var pointTarget: pointTarget
  @EnvironmentObject var armyControl: armyController
  @EnvironmentObject var collectionDatas: collectionData
  var body: some View {
    VStack(alignment: .trailing) {
      NavigationLink(destination: EmptyView()) {
        EmptyView()
      }
      NavigationLink(
        destination: troopDetailedView(Unit: unit, factionID: faction).environmentObject(
          collectionDatas)
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

extension troopCountSelect {
  @ViewBuilder
  private func pickerView() -> some View {  // Маленький View отображающий кнопки + и - для добавления или удаления юнита, количество этого юнита и его цену в очках
    HStack {
      Text("\(pointcount) pts").foregroundColor(.white)
        .padding(.vertical, 8).padding(.horizontal, 40)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(.teal)
        )
      Spacer()
      Button(action: {
        if armyControl.armies[armyControl.armies.count - 1].troops[unit.id]! != 0 {
          let armyID = armyControl.armies.count - 1
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
      Text("\(armyControl.armies[armyControl.armies.count - 1].troops[unit.id]!)")
      Button(action: {
        let armyID = armyControl.armies.count - 1
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
