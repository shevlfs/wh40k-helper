//
//  DataController.swift
//  armybuilder
//
//  Created by shevlfs on 3/25/22.
//

import Foundation
import SwiftUI
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Army")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }	
        }
    }
    
}

