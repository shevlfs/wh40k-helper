import Foundation

class Army: ObservableObject {
    @Published var points: Int = 0
    @Published var id = Int()
    @Published var faction = "Default"
    @Published var troops = [Int]()
    func addTroops(_ id: Int) {
        self.troops.append(id)
    }
    func changeFaction(_ fctn: String){
        self.faction = fctn
    }
}

class ArmyViewModel: ObservableObject {
    @Published var armies = [Int]()
    
    func getArmies() {
        self.armies = [1,2,3]
    }
}
