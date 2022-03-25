import Foundation

//struct Army: Identifiable {
//    var points: Int = 0
//    var id = Int()
//    var faction = "Default"
//    var troops = [Int]()
//
//    mutating func addPoints(_ amount: Int) {
//        self.points += amount
//    }
//    mutating func addTroops(_ id: Int) {
//        self.troops.append(id)
//    }
//    mutating func changeFaction(_ fctn: String){
//        self.faction = fctn
//    }
//}
//
class ArmyViewModel: ObservableObject {
    @Published var armies = [Int]()

    func getArmies() {
        self.armies = [1,2,3]
    }
}

extension Army {

    
    func addPoints(_ amount: Int) {
        self.points += Int16(amount)
    }
    func addTroops(_ id: Int16,_ count: Int16) {
        self.troops![id]! += count
    }
    func changeFaction(_ fctn: Int){
        self.factionID = Int16(fctn)
    }
}
