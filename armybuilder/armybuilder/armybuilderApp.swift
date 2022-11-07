import SwiftUI

@main
struct armybuilderApp: App { // Главная функция приложения и его запуск
  @StateObject var collectionDatas = collectionData()
  @StateObject var reloadControl = reloadController()
  @StateObject var armyControl = armyController()
  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(armyControl).environmentObject(reloadControl)
        .environmentObject(collectionDatas)
    }
  }
}
