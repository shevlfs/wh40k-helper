import SwiftUI

struct collectionAddUnits: View {
  @State var factionfile = Int()
  @EnvironmentObject var collectionDatas: collectionData
  @State var searchText = String()
  var body: some View {
    ScrollView(.vertical) {
        HStack {
          Text("Add units to collection").font(.largeTitle).fontWeight(.semibold)
          Spacer()
        }.padding()
      HStack {
        Text("Select units for your colleciton ").fontWeight(.regular).padding(
          [.leading, .bottom, .trailing]
        ).font(.title3)
      }
      VStack(alignment: .center) {
        ForEach(searchResults) { unit in
          ZStack {
            collectionSelection(
              factionID: factionfile,
              unitcount: collectionDatas.collectionDict[factionfile]![unit.id]!,
              unitname: unit.name, unitID: unit.id
            ).environmentObject(collectionDatas)
          }
        }.searchable(text: $searchText)
      }
    }
  }
  var searchResults: [unit] {
    if searchText.isEmpty {
      return globalstats[factionfile].units
    } else {
      return globalstats[factionfile].units.filter {
        $0.name.lowercased().contains(searchText.lowercased())
      }
    }
  }
}

struct collectionAddUnits_Previews: PreviewProvider {
  static var previews: some View {
    collectionAddUnits()
  }
}
