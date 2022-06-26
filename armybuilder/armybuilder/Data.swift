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
    var mods : [Int: [modification]] = [:]
    init(factionID: Int, armyid: Int){
        for unit in globalstats[factionID].units{
            self.troops[unit.id] = 0
            self.mods[unit.id] = [modification]()
        }
        self.factionID = factionID
        self.troops[0] = 0
        self.armyid = armyid
    }
}

struct modification: Identifiable{
    var id = UUID()
    var name: String
    var range: String
    var type: String
    var s: String
    var ap : Int
    var d : String
    var pts: Int
    var count : Int
    init(){
        self.name = ""
        self.range = ""
        self.type = ""
        self.s = ""
        self.ap = 0
        self.d = ""
        self.pts = 0
        self.count = 1
    }
}

func getRange(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->String{
    return armyControl.armies[armyID].mods[unitID]![modID].range
}

func getType(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->String{
    return armyControl.armies[armyID].mods[unitID]![modID].type
}

func getPTS(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->Int{
    return armyControl.armies[armyID].mods[unitID]![modID].pts
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
                troops.append(unitTemp(unitid: unit.id))
            }
        }
        if(armies[armyID-1].troops[0] != 0){
            troops.append(unitTemp(unitid: 0))
        }
        return troops
    }
}

