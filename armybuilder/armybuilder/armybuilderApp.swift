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
    @StateObject var reloadControl = reloadController()
    @StateObject var armyControl = armyController()
    @State var armyLoaded = false
    var body: some Scene {
        WindowGroup{
            if (!cookieExists){
            loginAuth().onAppear(perform:{
                serverHandshake()
            })
            } else{
                if (reloadControl.reloadNeeded == true){
                    ContentViewLogged().environmentObject(fillarmycontrol(armyControl: armyControl)).environmentObject(fillcollectiondata(collectionDatas: collectionDatas)).environmentObject(reloadControl).onAppear(perform:{
                        reloadControl.reloadNeeded = false
                        print(armyControl.armies)
                    })
                } else {
                ContentViewLogged().environmentObject(armyControl).environmentObject(collectionDatas).environmentObject(reloadControl)
                }
            }
                
                
        }
    }
}



func fillarmycontrol(armyControl: armyController)->armyController{
    let group = DispatchGroup()
    let internalQueue = DispatchQueue(label: "InternalQueue")
            group.enter()
    internalQueue.async
     {
            DispatchQueue.main.sync {
                let tempArmyList = getArmyControl()
                armyControl.armies = [Army]()
                for tempArmy in tempArmyList{
                var mappedDict = [Int:Int]()
                var done = false
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
                    
                    army.custinit(name: tempArmy.name, armyid: armyControl.armies.count + 1, factionID: tempArmy.factionid
                              , pointCount: tempArmy.pointCount, troops: mappedDict, mods: tempmods, deleted: false)
                    
                    
                armyControl.armies.append(army)
                    print(army.name ,army.pointCount)
                }
                group.leave()
            }
            
            group.notify(queue: .main) {
                print("Simulation finished")
            }
     }
    return armyControl
}

func fillcollectiondata(collectionDatas: collectionData)->collectionData{
    let tempCollection = getCollectionDatas()
    collectionDatas.collectionDict = tempCollection
    return collectionDatas
}
