//
//  JSONstructs.swift
//  armybuilder
//
//  Created by ted on 3/22/22.
//

import Foundation

struct faction: Identifiable,Decodable {
    let id: Int
    let name: String
    let file: String
}

var factions: [faction] = load("factions.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


struct unit: Identifiable,Decodable {
    var id: Int
    let name: String
    let m: String
    let ws: String
    let bs: String
    let s: Int
    let t: Int
    let w: Int
    let a: Int
    let ld: Int
    let sv: String
}
var greyknightsunits: [unit] = load(factions[0].file)
var spacewolvesunits: [unit] = load(factions[1].file)
