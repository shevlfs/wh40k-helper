import SwiftUI

struct addUnitMods: View { // View отображающий меню выбора модификаций 
  @EnvironmentObject var armyControl: armyController
  @State var searchBarMods = [String]()
  @State var armyID: Int
  @State private var searchText = ""
  @State var Unit: unit
  @State var addMod: Bool? = nil
  @State var modID = Int()
  var body: some View {
    NavigationView {
      VStack {
        ScrollView {
          HStack {
            NavigationLink(
              destination: addCustomMod(
                armyID: armyID, Unit: Unit

              ).environmentObject(armyControl), tag: true, selection: $addMod
            ) {
              EmptyView()
            }
              Button(action: {self.addMod = true}){
                  Text("Add custom...")
                    .font(.title2).foregroundColor(.blue)
                    .fontWeight(.semibold)
              }
          }.padding()
          ForEach(searchResults) { mod in
            NavigationLink(
              destination: addExistingMod(
                armyID: armyID, Unit: Unit, Name: mod.name, Range: mod.range, TypeM: mod.type,
                S: mod.s, AP: mod.ap, D: mod.d, PTS: 0, Count: 1, mod: mod)
            ) {
              modDisplay(mod: mod)
            }
          }.searchable(text: $searchText)
        }
      }.navigationTitle("Add modifications")
    }
  }
  var searchResults: [mod] { // результаты поиска 
    if searchText.isEmpty {
      return mods
    } else {
      return mods.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
  }
}
