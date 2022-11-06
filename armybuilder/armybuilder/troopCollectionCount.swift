import SwiftUI

struct troopCollectionCount: View { // View для отображения юнитов состоящих в коллекции при создании армии
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
      Text(unitname)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(.green)
        )

      pickerView()
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
  }
}

extension troopCollectionCount {
  @ViewBuilder
  private func pickerView() -> some View { // Маленький View отображающий кнопки + и - для добавления или удаления юнита, количество этого юнита и его цену в очках
    HStack {
      Text("\(pointcount) pts").foregroundColor(.white)
        .padding(.vertical, 8).padding(.horizontal, 40)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(.green)
        )
      Spacer()
      Button(action: {
        if unitcount != 0 {
          unitcount -= 1
          let armyID = armyControl.armies.count - 1
          armyControl.armies[armyID].pointCount -= pointcount
          armyControl.armies[armyID].troops[unit.id]! -= 1
        }
      }) {
        Text("-")
          .foregroundColor(.white)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(RoundedRectangle(cornerRadius: 5).fill(.green))
      }
      Text("\(unitcount)")
      Button(action: {
        unitcount += 1
        let armyID = armyControl.armies.count - 1
        armyControl.armies[armyID].pointCount += pointcount
        armyControl.armies[armyID].troops[unit.id]! += 1
      }) {
        Text("+")
          .foregroundColor(.white)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(RoundedRectangle(cornerRadius: 5).fill(.green))
      }
    }
  }
}
