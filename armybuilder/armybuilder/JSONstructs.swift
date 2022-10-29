//
//  JSONstructs.swift
//  armybuilder
//
//  Created by ted on 3/22/22.
//

import Foundation

struct faction: Identifiable,Decodable { // структура для фракции
    let id: Int
    let name: String
    let file: String
}

var factions: [faction] = load("factions.json") // создания массива factions из json'а

func load<T: Decodable>(_ filename: String) -> T { // фунцкия парсинга json файла
    
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


struct unit: Identifiable,Decodable { // структура юнита
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
    
    private enum CodingKeys: String, CodingKey { // enum для парсинга
        case id, name = "Name",m="M",ws="WS",bs="BS",s="S",t="T",w="W",a="A",ld="Ld",sv="Sv",pts="pts"
    }
    init(from decoder: Decoder) throws // инициализация через парсинг из json файла
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
                print(self.name)
        }

}
struct stats: Identifiable, Decodable{ // структура для хранения всей информации о юнитах и фракциях
    var id: Int
    let units: [unit]
    private enum CodingKeys : String, CodingKey {
        case units, id = "factid"
    }
}
var globalstats: [stats] = load("stats.json")


struct mod: Identifiable,Decodable { // структура для модификации
    var id: Int
    let name: String
    let range: String
    let type: String
    let s: String
    let ap: Int
    let d: String

    private enum CodingKeys: String, CodingKey { // codingkeys для парсинга модификаций из json'a
        case id, name = "name", range = "range", type = "type", s = "s", ap =  "ap", d  = "d"
    }
    init(from decoder: Decoder) throws // инициализация через парсинг из json файла
            {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                do
                {
                    range = try String(container.decode(Int.self, forKey: .range))
                }
                catch
                {
                    range = try container.decode(String.self, forKey: .range)
                }
                self.id = try container.decode(Int.self, forKey: .id)
                self.type = try container.decode(String.self, forKey: .type)
                self.ap = try container.decode(Int.self, forKey: .ap)
                do
                {
                    d = try String(container.decode(Int.self, forKey: .d))
                }
                catch
                {
                    d = try container.decode(String.self, forKey: .d)
                }
                self.name = try container.decode(String.self, forKey: .name)
                do
                {
                    s = try String(container.decode(Int.self, forKey: .s))
                }
                catch
                {
                    s = try container.decode(String.self, forKey: .s)
                }
        }

}
var mods: [mod] = load("mods.json")
func modNames()->[String]{ // функция получения названий всех модификаций
    var answ = [String]()
    for mod in mods{
        answ.append(mod.name)
    }
    return answ
}
