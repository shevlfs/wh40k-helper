import SwiftUI

struct collectionSelection: View { // View отображающий конкретный юнит при изменении коллекции
  @EnvironmentObject var collectionDatas: collectionData
  @State var factionID: Int
  @State var unitcount: Int
  @State var unitname = String()
  @State var unitID: Int
  var body: some View {
    VStack(alignment: .trailing) {
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

extension collectionSelection {
  @ViewBuilder
  private func pickerView() -> some View { // Маленький View отображающий кнопки + и - для добавления или удаления юнита из коллекции, количество этого юнита в коллекции
    HStack {
      Button(action: {
        if collectionDatas.collectionDict[factionID]![unitID]! != 0 {
          collectionDatas.collectionDict[factionID]![unitID]! -= 1
        }
      }) {
        Text("-")
          .foregroundColor(.white)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(RoundedRectangle(cornerRadius: 5).fill(.green))
      }
      Text("\(collectionDatas.collectionDict[factionID]![unitID]!)")
      Button(action: {
        collectionDatas.collectionDict[factionID]![unitID]! += 1
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
