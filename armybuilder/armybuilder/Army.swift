import Foundation

class Army: ObservableObject {
    @Published var points: Int = 100
    @Published var id = 2
    @Published var faction = "Default"
    
    func addPoints(_ amount: Int) {
        self.points += amount
    }
    
}

class ArmyViewModel: ObservableObject {
    @Published var armies = [Int]()
    
    func getArmies() {
        self.armies = [1,2,3]
    }
}
