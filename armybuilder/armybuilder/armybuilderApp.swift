//
//  armybuilderApp.swift
//  armybuilder
//
//  Created by ted on 29.01.2022.
//

import SwiftUI


@main
struct armybuilderApp: App {
    @StateObject var collectionDatas = collectionData()
    @StateObject var reloadControl = reloadController()
    @StateObject var armyControl = armyController()
    var body: some Scene {
        WindowGroup{
            ContentView().environmentObject(armyControl).environmentObject(reloadControl).environmentObject(collectionDatas)
        }
    }
}
