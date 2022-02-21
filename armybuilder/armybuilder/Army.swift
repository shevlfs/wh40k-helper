import Foundation

class Army: ObservableObject {
    @Published var points: Int = 0
    
    func addPoints(_ amount: Int) {
        self.points += amount
    }
    
}

class ArmyViewModel: ObservableObject {
    @Published var armies = [Int]()
    
    func getArmies() {
        self.armies = [1]
    }
}
