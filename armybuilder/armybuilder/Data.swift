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

