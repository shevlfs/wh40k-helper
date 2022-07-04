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

struct Army: Identifiable, Encodable, Decodable{
    var id = UUID()
    var name = String()
    var armyid: Int
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
        self.name = "Army \(self.armyid)"
    }
    mutating func custinit(name: String, armyid: Int, factionID: Int, pointCount: Int, troops: [Int:Int]){
        self.name = name
        self.armyid = armyid
        self.factionID = factionID
        self.pointCount = pointCount
        self.troops = troops
    }
    func checkMods()->Bool{
        for unit in globalstats[factionID].units{
            if(!self.mods[unit.id]!.isEmpty){
                return true
            }
        }
        return false
    }
    func getCommandPoints()->Int{
        if (self.pointCount == 0){
            return 0
        }
        else if (self.pointCount <= 500){
            return 3
        }
        else if (self.pointCount <= 1000){
            return 6
        }
        else if (self.pointCount <= 2000){
            return 12
        } else {
            return 18
        }
    }
    func getBattleSize()->String{
        if (self.pointCount == 0){
            return "None"
        }
        else if (self.pointCount <= 500){
            return "Combat Patrol"
        }
        else if (self.pointCount <= 1000){
            return "Incursion"
        }
        else if (self.pointCount <= 2000){
            return "Strike Force"
        } else {
            return "Onslaught"
        }
    }
}

struct modification: Identifiable, Encodable, Decodable{
    var id = UUID()
    var name: String
    var range: String
    var type: String
    var s: String
    var ap : Int
    var d : String
    var pts: Int
    var count : Int
    init(name: String, range: String, type: String, s: String, ap:Int,d: String,pts: Int,count: Int){
        self.name = name
        self.range = range
        self.type = type
        self.s = s
        self.ap = ap
        self.d = d
        self.pts = pts
        self.count = count
    }
}

func getName(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->String{
    return armyControl.armies[armyID].mods[unitID]![modID].name
}

func getRange(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->String{
    return armyControl.armies[armyID].mods[unitID]![modID].range
}

func getType(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->String{
    return armyControl.armies[armyID].mods[unitID]![modID].type
}

func getAP(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->Int{
    return armyControl.armies[armyID].mods[unitID]![modID].ap
}

func getCount(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->Int{
    return armyControl.armies[armyID].mods[unitID]![modID].count
}

func getS(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->String{
    return armyControl.armies[armyID].mods[unitID]![modID].s
}

func getD(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->String{
    return armyControl.armies[armyID].mods[unitID]![modID].d
}

func getPTS(armyControl: armyController,armyID: Int, unitID: Int, modID: Int)->Int{
    return armyControl.armies[armyID].mods[unitID]![modID].pts
}










class armyController: ObservableObject{
    @Published var armies = [Army]()
    
    private enum CodingKeys : String, CodingKey {
        case armies = "armies"
    }
    
    init(){
        self.armies = [Army]()
    }
    
    func encode(to encoder: Encoder) throws{
        
    }
    
    
    
    
    
    func getPoints(armyID: Int) -> Int{
        return armies[armyID-1].pointCount
    }
    func getArmies()->[Army]{
        var armies = [Army]()
        for army in self.armies{
            if (army.armyid != -1){
                armies.append(army)
            }
        }
        return armies
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
    func getNextID()->Int{
        var temp = Int()
        for army in self.armies{
            if (army.armyid > temp){
                temp = army.armyid
            }
        }
        return temp
    }
    func getNames()->[armyTemp]{
        var temp = [armyTemp]()
        for army in self.armies{
            temp.append(armyTemp(id: army.armyid, name: army.name))
        }
        return temp
    }
    
}
struct armyTemp: Identifiable{
    var id = Int()
    var name = String()
}

struct serverArmy: Codable{
    var name = String()
    var armyid: Int
    var factionid: Int
    var pointCount = 0
    var troops : [String:Int] = [:]
    var mods : [String: [modification]] = [:]
}



class viewController: ObservableObject{
    @Published var showingaddArmy = false
    init(){
        }
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
