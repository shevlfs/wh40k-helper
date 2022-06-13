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
    let pts: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, name = "Name",m="M",ws="WS",bs="BS",s="S",t="T",w="W",a="A",ld="Ld",sv="Sv",pts="pts"
    }
    init(from decoder: Decoder) throws
            {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                do
                {
                    m = try String(container.decode(Int.self, forKey: .m))
                }
                catch
                {
                    m = try container.decode(String.self, forKey: .m)
                }
                self.id = try container.decode(Int.self, forKey: .id)
                self.name = try container.decode(String.self, forKey: .name)
                self.ws = try container.decode(String.self, forKey: .ws)
                self.bs = try container.decode(String.self, forKey: .bs)
                self.s = try container.decode(Int.self, forKey: .s)
                self.t = try container.decode(Int.self, forKey: .t)
                self.w = try container.decode(Int.self, forKey: .w)
                self.a = try container.decode(Int.self, forKey: .a)
                self.ld = try container.decode(Int.self, forKey: .ld)
                self.sv = try container.decode(String.self, forKey: .sv)
                self.pts = try container.decode(Int.self, forKey: .pts)
        }

}
struct stats: Identifiable, Decodable{
    var id: Int
    let units: [unit]
    private enum CodingKeys : String, CodingKey {
        case units, id = "factid"
    }
}
var globalstats: [stats] = load("stats.json")
