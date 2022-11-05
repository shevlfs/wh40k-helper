import SwiftUI

struct troopCollectionEditCount: View { // View, который отображает юниты, которые находятся в коллекции, при изменении армии (вызывается в editArmy)
  @State var unitCount: Int
  @State var unitName = String()
  @State var pointCount = Int()
  @State var unit: unit
  @State var armyID: Int
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
        Text(unitName)
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(.green)
          )
      }.isDetailLink(false)
      pickerView()
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
  }
}

extension troopCollectionEditCount {
  @ViewBuilder
  private func pickerView() -> some View {
    HStack {
      Text("\(pointCount) pts").foregroundColor(.white)
        .padding(.vertical, 8).padding(.horizontal, 40)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(.green)
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
          armyControl.armies[armyID].pointCount -= pointCount
          armyControl.armies[armyID].troops[unit.id]! -= 1
        } else if armyControl.armies[armyID].troops[unit.id]! != 0 {
          armyControl.armies[armyID].pointCount -= pointCount
          armyControl.armies[armyID].troops[unit.id]! -= 1
        }
      }) {
        Text("-")
          .foregroundColor(.white)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(RoundedRectangle(cornerRadius: 5).fill(.green))
      }
      Text("\(armyControl.armies[armyID].troops[unit.id]!)")
      Button(action: {
        armyControl.armies[armyID].pointCount += pointCount
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
