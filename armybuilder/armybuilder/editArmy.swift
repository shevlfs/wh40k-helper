import SwiftUI

struct editArmy: View {  // View отображающий меню изменения армии
  @State var factionfile = Int()
  @State var currentpoints = Int()
  @State var targetMenu = false
  @State var targetPopUp = false
  @State var armyID: Int
  @EnvironmentObject var pointTarget: pointTarget
  @EnvironmentObject var collectionDatas: collectionData
  @EnvironmentObject var armyControl: armyController
  @State var collectionShowcase: Bool
  @State var searchText = String()
  @State var collectionHidden = false
  @Environment(\.presentationMode) var presentationMode
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          if pointTarget.isPointTargetOn == false {
            Button(action: { self.targetMenu.toggle() }) {
              Text("\(armyControl.armies[armyID].pointCount) pts").foregroundColor(.white)
                .frame(width: 195, height: 10)
                .padding()
                .background(
                  RoundedRectangle(cornerRadius: 8)
                    .fill(.green)
                ).sheet(isPresented: $targetMenu) {
                  if #available(iOS 16.0, *) {
                    targetPicker().environmentObject(pointTarget).presentationDetents([.medium])
                  } else {
                    targetPicker().environmentObject(pointTarget)
                  }
                }
            }

          } else {

            if armyControl.armies[armyID].pointCount > pointTarget.pointTargetCount {
              Button(action: { self.targetMenu.toggle() }) {
                Text(
                  "\(armyControl.armies[armyID].pointCount) pts / \(pointTarget.pointTargetCount) pts "
                ).foregroundColor(.white)
                  .frame(width: 195, height: 10)
                  .padding()
                  .background(
                    RoundedRectangle(cornerRadius: 8)
                      .fill(.red)
                  ).sheet(isPresented: $targetMenu) {
                    if #available(iOS 16.0, *) {
                      targetPicker().environmentObject(pointTarget).presentationDetents([.medium])
                    } else {
                      // Fallback on earlier versions
                      targetPicker().environmentObject(pointTarget)
                    }
                  }
              }

            } else {
              Button(action: { self.targetMenu.toggle() }) {
                Text(
                  "\(armyControl.armies[armyID].pointCount) pts / \(pointTarget.pointTargetCount) pts "
                ).foregroundColor(.white)
                  .frame(width: 195, height: 10)
                  .padding()
                  .background(
                    RoundedRectangle(cornerRadius: 8)
                      .fill(.green)
                  ).sheet(isPresented: $targetMenu) {
                    if #available(iOS 16.0, *) {
                      targetPicker().environmentObject(pointTarget).presentationDetents([.medium])
                    } else {
                      // Fallback on earlier versions
                      targetPicker().environmentObject(pointTarget)
                    }
                  }
              }

            }
          }
        }.padding()

        if collectionShowcase == false {
          ScrollView(.vertical) {
            VStack(alignment: .center) {
              HStack {
                Text("Troops:").font(.title)
                  .fontWeight(.bold)
                Spacer()
              }.padding()
              ForEach(searchResults) { unit in
                ZStack {
                  troopEditSelect(
                    unitcount: 0, unitname: unit.name, pointcount: unit.pts, unit: unit,
                    armyID: armyID
                  ).environmentObject(pointTarget).environmentObject(armyControl)
                }
              }.searchable(text: $searchText)
            }
          }
        } else if collectionHidden == false {
          ScrollView(.vertical) {
            VStack {
              HStack {
                Text("In your collection:")
                  .font(.title)
                  .fontWeight(.bold)
                Spacer()
                Button(action: {
                  self.collectionHidden.toggle()
                }) {
                  Image(systemName: "minus")
                }
              }.padding()
              VStack(alignment: .center) {
                ForEach(
                  collectionDatas.getUnits(factionID: factionfile)
                ) { unit in
                  ZStack {
                    troopCollectionEditCount(
                      unitCount: armyControl.armies[armyID].troops[unit.unitid] ?? 999,
                      unitName: globalstats[factionfile].units[unit.unitid - 1].name,
                      pointCount: globalstats[factionfile].units[unit.unitid - 1].pts,
                      unit: globalstats[factionfile].units[unit.unitid - 1], armyID: armyID,
                      faction: factionfile
                    ).environmentObject(pointTarget).environmentObject(armyControl)

                  }
                }
              }.padding(.vertical)

            }
            VStack(alignment: .center) {
              HStack {
                Text("Troops:").font(.title)
                  .fontWeight(.bold)
                Spacer()
              }.padding()
              ForEach(searchResults) { unit in
                ZStack {
                  troopEditSelect(
                    unitcount: armyControl.armies[armyControl.armies.count - 1].troops[unit.id]
                      ?? 999, unitname: unit.name, pointcount: unit.pts, unit: unit, armyID: armyID
                  ).environmentObject(pointTarget).environmentObject(armyControl)
                }
              }.searchable(text: $searchText)
            }
          }

        } else {
          ScrollView(.vertical) {
            VStack {
              HStack {
                Text("In your collection:")
                  .font(.title)
                  .fontWeight(.bold)
                Spacer()
                Button(action: {
                  self.collectionHidden.toggle()
                }) {
                  Image(systemName: "plus")
                }
              }.padding()

            }
            VStack(alignment: .center) {
              HStack {
                Text("Troops:").font(.title)
                  .fontWeight(.bold)
                Spacer()
              }.padding()
              ForEach(searchResults) { unit in
                ZStack {
                  troopEditSelect(
                    unitcount: armyControl.armies[armyControl.armies.count - 1].troops[unit.id]
                      ?? 999, unitname: unit.name, pointcount: unit.pts, unit: unit, armyID: armyID
                  ).environmentObject(pointTarget).environmentObject(armyControl)
                }
              }.searchable(text: $searchText)
            }
          }

        }
      }
      .navigationBarTitle("Edit Army").toolbar {
        ToolbarItemGroup(placement: .primaryAction) {
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }) {
            Text("Done")
          }
        }
      }
    }
  }
  var searchResults: [unit] {  // результаты поиска
    if searchText.isEmpty {
      return globalstats[factionfile].units
    } else {
      return globalstats[factionfile].units.filter {
        $0.name.lowercased().contains(searchText.lowercased())
      }
    }
  }

}
