//
//  armybuilderApp.swift
//  armybuilder
//
//  Created by ted on 29.01.2022.
//

import SwiftUI


@main
struct armybuilderApp: App { // главная функция всего приложения в которой определяется запускать экран авторизации или загружать информацию с бекэнда и запускать главное меню
    @StateObject var collectionDatas = collectionData()
    @StateObject var reloadControl = reloadController()
    @StateObject var armyControl = armyController()
    var body: some Scene {
        WindowGroup{
            ContentView().environmentObject(armyControl).environmentObject(reloadControl).environmentObject(collectionDatas)
        }
    }
    var filledarmycontrol: armyController {
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
                    print("Data Loaded")
                }
         }
        return armyControl
    }
}





func fillCollectionInfo(collectionDatas: collectionData)->collectionData{
    let tempCollection = getCollectionDatas()
    collectionDatas.collectionDict = tempCollection
    return collectionDatas
}

func fillArmyControlInfo(armyControl: armyController)->armyController{
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
    }
    return armyControl
}
