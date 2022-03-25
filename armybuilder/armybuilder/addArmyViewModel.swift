//
//  addArmyViewModel.swift
//  armybuilder
//
//  Created by shevlfs on 3/25/22.
//

import Foundation
import CoreData

class AddArmyViewModel: ObservableObject {
    let context: NSManagedObjectContext
    let army: Army
    var units: [unit] {
        return globalstats[Int(factionID)].units
    }
    
    @Published var unitCount: [unit: Int] = [:]
    
    @Published var factionID: Int16 = 0 {
        didSet {
            army.factionID = self.factionID
        }
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.army = Army(context: context)
        self.army.id = UUID()
    }
    
    func addArmy() {
        try! context.save()
    }
    
    func onDisappear() {
        context.delete(army)
    }
    
    
}
