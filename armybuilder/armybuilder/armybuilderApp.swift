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
    var cookieExists = cookieCheck()
    @StateObject var armyControl = armyController()
    var body: some Scene {
        WindowGroup{
            if (!cookieExists){
            loginAuth().onAppear(perform:{
                serverHandshake()
            })
            } else{
                ContentView().environmentObject(fillarmycontrol(armyControl: armyControl))
            }
                
                
        }
    }
}

func cookieCheck()->Bool{
    let cookieJar = HTTPCookieStorage.shared
    for cookie in cookieJar.cookies! {
       if cookie.name == "session" {
           return true
       }
    }
    return false
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
    }
    return armyControl
}
