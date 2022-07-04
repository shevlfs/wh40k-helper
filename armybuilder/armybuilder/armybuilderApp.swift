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
                    ContentViewLogged().environmentObject(fillarmycontrol(armyControl: armyControl)).environmentObject(fillcollectiondata(collectionDatas: collectionDatas)).onAppear(perform:{
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
        
        var tempmods: [Int : [modification]] = [:]
        for unit in tempArmy.mods.keys{
            let intkey = Int(unit)
            tempmods[intkey!] = [modification]()
            if (!tempArmy.mods[unit]!.isEmpty){
                for mod in tempArmy.mods[unit]!{
                    tempmods[intkey!]!.append(modification(name: mod.name, range: mod.range, type: mod.type, s: mod.s, ap: mod.ap, d: mod.d, pts: mod.pts, count: mod.count))
                }
            }
        }
        
    army.custinit(name: tempArmy.name, armyid: tempArmy.armyid, factionID: tempArmy.factionid
                  , pointCount: tempArmy.pointCount, troops: mappedDict, mods: tempmods, deleted: tempArmy.deleted)
        
        
    armyControl.armies.append(army)
        print(army.pointCount)
        
        
    }
    return armyControl
}

func fillcollectiondata(collectionDatas: collectionData)->collectionData{
    let tempCollection = getCollectionDatas()
    collectionDatas.collectionDict = tempCollection
    return collectionDatas
}
