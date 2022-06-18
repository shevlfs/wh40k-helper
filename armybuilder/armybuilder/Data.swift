import Foundation


class collectionData: ObservableObject{
    @Published var collectionDict: [Int : [Int: Int]] = [:]
    init(){
        for faction in factions{
            collectionDict[faction.id] = [:]
            for unit in globalstats[faction.id].units{
                collectionDict[faction.id]![unit.id] = 0
            }
        }
    }
    func emptyChecker (factionID: Int) -> Bool{
        for unit in globalstats[factionID].units{
            if (collectionDict[factionID]![unit.id] != 0){
                return true
            }
        }
        return false
    }
    
    func getUnits (factionID: Int) -> [unitTemp]{
        var units = [unitTemp]()
        for unit in globalstats[factionID].units{
            if (collectionDict[factionID]![unit.id] != 0){
                units.append(unitTemp(unitid: unit.id))
            }
        }
        return units
    }
}

struct unitTemp: Identifiable{
    let id = UUID()
    let unitid: Int
}

struct Army: Identifiable{
    let id = UUID()
    let armyid: Int
    var factionID: Int
    var pointCount = 0
    var troops : [Int:Int] = [:]
    init(factionID: Int, armyid: Int){
        for unit in globalstats[factionID].units{
            self.troops[unit.id] = 0
        }
        self.factionID = factionID
        self.armyid = armyid
    }
}


class armyController: ObservableObject{
    @Published var armies = [Army]()
    @Published var armyViews = [Int]()
    
    func getPoints(armyID: Int) -> Int{
        return armies[armyID-1].pointCount
    }
    func getTroops(armyID: Int) -> [unitTemp]{
        var troops = [unitTemp]()
        for unit in globalstats[armies[armyID-1].factionID].units{
            if (armies[armyID-1].troops[unit.id] != 0){
                troops.append(unitTemp(unitid: unit.id-1))
            }
        }
        return troops
    }
}

