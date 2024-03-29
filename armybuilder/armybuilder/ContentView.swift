import SwiftUI

struct ContentView: View {  // View с главным меню (отсюда же вызывается modal с экраном регистрации)
  @EnvironmentObject var collectionDatas: collectionData
  @EnvironmentObject var armyControl: armyController
  @EnvironmentObject var reloadControl: reloadController
  @StateObject var viewControl = viewController()
  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        HStack {
          if reloadControl.showLoginScreen == true {
            EmptyView()
          } else {
            Text("Your armies").font(.largeTitle).fontWeight(.semibold).padding()
          }
          Spacer()
        }
        VStack {

          if armyControl.armies.isEmpty {
            Spacer()
            if reloadControl.showLoginScreen == true {
              EmptyView()
            } else {
              Text("No armies! :(").fontWeight(.light).padding()
            }
          } else {
            ForEach(armyControl.armies, id: \.id) { army in
              if !army.deleted {
                NavigationLink(
                  destination: armyDetailedView(id: army.armyid).environmentObject(collectionDatas)
                    .environmentObject(armyControl)
                ) {
                  // вызов View с детальным просмотром армии
                  armyView(id: army.armyid, faction: factions[army.factionID].name)
                    .environmentObject(armyControl).environmentObject(collectionDatas)
                }.contextMenu {
                  Button(
                    role: .destructive,
                    action: {
                      deleteArmy(army: army)
                      armyControl.armies[army.armyid - 1].deleted = true
                      armyControl.armies = fillArmyControlInfo(armyControl: armyControl).armies
                    }
                  ) {
                    HStack {
                      Text("Delete")
                      Image(systemName: "trash")
                    }
                  }
                  Button(action: {}) {
                    Text("Cancel")

                  }
                }

              }

            }
          }
          NavigationLink(
            destination: appSettings().environmentObject(collectionDatas).environmentObject(
              reloadControl), tag: true, selection: $reloadControl.showSettings
          ) {
            EmptyView()  // вызов настроек приложения
          }

        }

      }.toolbar {
        ToolbarItemGroup(placement: .primaryAction) {
          Button(action: {
            viewControl.showingaddArmy = true
          }) {
            Label("Add", systemImage: "plus.app")
          }.sheet(isPresented: $viewControl.showingaddArmy) {
            addArmyDialog().environmentObject(viewControl).environmentObject(collectionDatas)
              .environmentObject(armyControl).interactiveDismissDisabled()
          }

        }
      }.toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading) {
          Button(action: {
            reloadControl.showSettings = true
          }) {
            Label("Settings", systemImage: "gear")
          }
        }
      }
    }.navigationViewStyle(.stack).onAppear(perform: {
      if reloadControl.userAlreadyLogged {
        reloadControl.currentUser = whoami()
        armyControl.armies = fillArmyControlInfo(armyControl: armyControl).armies
        collectionDatas.collectionDict =
          fillCollectionInfo(collectionDatas: collectionDatas).collectionDict
      }
    }).fullScreenCover(isPresented: $reloadControl.showLoginScreen) {
      loginAuth().environmentObject(reloadControl).environmentObject(armyControl).environmentObject(
        collectionDatas)
    }
  }
}
