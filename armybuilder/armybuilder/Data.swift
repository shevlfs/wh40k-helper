import Foundation


class collectionData: ObservableObject{ // Объект для хранения информации о коллекции пользователя
    @Published var collectionDict: [Int : [Int: Int]] = [:]
    init(){ // инициализация
        for faction in factions{
            collectionDict[faction.id] = [:]
            for unit in globalstats[faction.id].units{
                collectionDict[faction.id]![unit.id] = 0
                print(faction.id)
            }
        }
    }
    func emptyChecker (factionID: Int) -> Bool{ // проверка на пустоту
        for unit in globalstats[factionID].units{
            if (collectionDict[factionID]![unit.id] != 0){
                return true
            }
        }
        return false
    }
    
    func getUnits (factionID: Int) -> [unitTemp]{ // получение всех юнитов от конкретной фракции которые есть в коллекции
        var units = [unitTemp]()
        for unit in globalstats[factionID].units{
            if (collectionDict[factionID]![unit.id] != 0){
                units.append(unitTemp(unitid: unit.id))
            }
        }
        return units
    }
}

struct unitTemp: Identifiable{ // времененная структура для хранения юнита
    let id = UUID()
    let unitid: Int
}

struct Army: Identifiable{ // структура для армии
    var id = UUID()
    var name = String()
    var armyid: Int
    var factionID: Int
    var pointCount = 0
    var troops : [Int:Int] = [:]
    var mods : [Int: [modification]] = [:]
    var deleted = false
    init(factionID: Int, armyid: Int){ // инициализация
        for unit in globalstats[factionID].units{
            self.troops[unit.id] = 0
            self.mods[unit.id] = [modification]()
        }
        self.factionID = factionID
        self.troops[0] = 0
        self.armyid = armyid
        self.name = "Army \(self.armyid)"
    }
    mutating func custinit(name: String, armyid: Int, factionID: Int, pointCount: Int, troops: [Int:Int], mods: [Int: [modification]], deleted: Bool){
        // mutating функция для создания армии при получении её с бекенда
        self.name = name
        self.armyid = armyid
        self.factionID = factionID
        self.pointCount = pointCount
        self.troops = troops
        self.mods = mods
        self.deleted = deleted
    }
    mutating func setName (armyControl: armyController){ // функция для задания имени армии при изменении его
        var ids = [Int]()
        for army in armyControl.armies{
            if army.name.contains("Army"){
                let decimalCharacters = CharacterSet.decimalDigits
                let decimalRange = army.name.rangeOfCharacter(from: decimalCharacters)
                if decimalRange != nil {
                    ids.append(Int.parse(from: army.name)!)
                }
            }
        }
        if (!ids.isEmpty){
        self.name = "Army \(ids.max()!+1)"
        } else{
            self.name = "Army 1"
        }
        
    }
    func checkMods()->Bool{ // проверка на наличие модификаций у юнита
        for unit in globalstats[factionID].units{
            if(!self.mods[unit.id]!.isEmpty){
                return true
            }
        }
        return false
    }
    func emptyChecker()->Bool{ // проверка на пустоту армии
        for unit in globalstats[self.factionID].units{
            if self.troops[unit.id] != 0{
                return false
            }
        }
        return true
    }
    func getCommandPoints()->Int{ // функция для получения типа подразделения армии
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
    func getBattleSize()->String{ // функция для получения размера битвы от армии
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

struct modification: Identifiable{ // структура для модификации
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
        // инициализация
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
// далее идут функции-геттеры, в целом, их названия говорят сами за себя
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










class armyController: ObservableObject{ // объект для хранения всех армий
    @Published var armies = [Army]()
    private enum CodingKeys : String, CodingKey { // enum для парсинга с бекенда
        case armies = "armies"
    }
    
    init(){ // инициализация
        self.armies = [Army]()
    }
    
    func getPoints(armyID: Int) -> Int{ // функция для получения количества очков
        return armies[armyID-1].pointCount
    }
    
    func getArmies()->[Army]{ // функция для получения массива действительных армий
        var armies = [Army]()   
        for army in self.armies{
            if (army.armyid != -1){
                armies.append(army)
            }
        }
        return armies
    }
    
    func getTroops(armyID: Int) -> [unitTemp]{ // функция для получения массива юнитов от конкретной армии
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
    
    func getNextID()->Int{ // функция для получения id армии для её названия во время её создания
        var temp = Int()
        for army in self.armies{
            if (army.armyid > temp){
                temp = army.armyid
            }
        }
        return temp
    }
    
    func getNames()->[armyTemp]{ // функция для получения названий армий
        var temp = [armyTemp]()
        for army in self.armies{
            temp.append(armyTemp(id: army.armyid, name: army.name))
        }
        return temp
    }
    
}
struct armyTemp: Identifiable{ // временная структура для армии
    var id = Int()
    var name = String()
}

struct serverArmy: Codable{ // временная структура для парсинга армии с бекенда
    var name = String()
    var armyid: Int
    var factionid: Int
    var pointCount = 0
    var troops : [String:Int] = [:]
    var mods : [String: [serverMod]] = [:]
    var deleted = false
}

struct serverMod: Codable { // временная структура для парсинга модификации с бекенда
    var name = String()
    var range = String()
    var type = String()
    var s = String()
    var ap = Int()
    var d = String()
    var pts = Int()
    var count = Int()
}



class viewController: ObservableObject{
    @Published var showingaddArmy = false
    @Published var addingmod = false
    init(){
        }
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

class reloadController: ObservableObject{

    @Published var showLoginScreen = true
    @Published var logOutPerformed = false
    @Published var currentUser = String()
    @Published var userAlreadyLogged = false
    init() {
        if (loadCookies()){
            self.showLoginScreen = false
            self.userAlreadyLogged = true
        }
    }
}


extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
