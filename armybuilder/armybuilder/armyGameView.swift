import SwiftUI


struct armyGameView: View { // View для отображения армии в "режиме игры"
  @State var armyID: Int
  @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
  @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  @EnvironmentObject var armyControl: armyController
  var body: some View {
      if (horizontalSizeClass == .regular){
          VStack {
              HStack {
                  TableHeader()
                  Spacer()
              }
              ScrollView {
                  ForEach(armyControl.getTroops(armyID: armyID + 1)) {
                      troop in
                      unitGameView(
                        id: troop.unitid - 1, armyID: armyID, factionID: armyControl.armies[armyID].factionID
                      ).environmentObject(armyControl).frame(maxWidth: .infinity, alignment: .leading)
                  }
              }
          }
      } else {
          VStack{
              HStack{
                  Text("Please flip your device to landscape mode.").font(.title2).fontWeight(.bold).padding().lineLimit(2)
                  Image(systemName: "arrow.turn.up.right").padding()
              }.padding()
              Spacer()
          }
      }
  }
}
