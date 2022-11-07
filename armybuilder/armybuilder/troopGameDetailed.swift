import SwiftUI

struct troopGameDetailed: View {  // View для отображения модификаций юнита в "режиме игры"
  @EnvironmentObject var armyControl: armyController
  @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
  @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  @State var armyID: Int
  @State var unitID: Int
  var body: some View {
    if horizontalSizeClass == .regular {
      VStack {
        tableUnitHeader(name: globalstats[armyControl.armies[armyID].factionID].units[unitID].name)
        ScrollView {
          if !armyControl.armies[armyID].mods[unitID + 1]!.isEmpty {
            ForEach(armyControl.armies[armyID].mods[unitID + 1]!) {
              mod in modGameView(mod: mod)
            }
          } else {
            Text("This troop has no mods.")
          }
        }
      }
    } else {
      VStack {
        HStack {
          Text("Please flip your device to landscape mode.").font(.title2).fontWeight(.bold)
            .padding().lineLimit(2)
          Image(systemName: "arrow.turn.up.right").padding()
        }.padding()
        Spacer()
      }
    }
  }
}
