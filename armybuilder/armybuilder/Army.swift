import Foundation

class Army: ObservableObject {
    @Published var points: Int = 100
    @Published var id = 2
    @Published var faction = "Default"
    @Published var troops = [Int]()
    func addPoints(_ amount: Int) {
        self.points += amount
    }
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
