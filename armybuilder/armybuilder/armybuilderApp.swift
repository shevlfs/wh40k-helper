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
    var cookieExists = loadCookies()
    @StateObject var armyControl = armyController()
    @State var armyLoaded = false
    var body: some Scene {
        WindowGroup{
            if (!cookieExists){
            loginAuth().onAppear(perform:{
                serverHandshake()
            })
            } else{
                if (armyLoaded == false){
                    ContentViewLogged().environmentObject(fillarmycontrol(armyControl: armyControl)).environmentObject(collectionDatas).onAppear(perform:{
                        armyLoaded = true
                    })
                } else {
                ContentViewLogged().environmentObject(armyControl).environmentObject(collectionDatas)
                }
            }
                
                
        }
    }
}



func fillarmycontrol(armyControl: armyController)->armyController{
    
    let tempArmyList = getArmyControl()
    for tempArmy in tempArmyList{
    var mappedDict = [Int:Int]()
    
    let mappedKeys = tempArmy.troops.map {Int( $0.key)}
    let zippedArray = Array((zip(mappedKeys, tempArmy.troops.map{$0.value})))
    for element in zippedArray {
        mappedDict[element.0!] = element.1
    }
    var army = Army(factionID: tempArmy.factionid, armyid: tempArmy.armyid)
    army.custinit(name: tempArmy.name, armyid: tempArmy.armyid, factionID: tempArmy.factionid
                  , pointCount: tempArmy.pointCount, troops: mappedDict)
    armyControl.armies.append(army)
        print(army.pointCount)
    }
    return armyControl
}
