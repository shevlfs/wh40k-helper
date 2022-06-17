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
}



