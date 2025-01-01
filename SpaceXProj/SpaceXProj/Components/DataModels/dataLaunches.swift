//
//  data.swift
//  SpaceXProj
//
//  Created by Max on 20.11.2024.
//

import Foundation

// MARK: - TopLevelElement
struct LauchSpaceX: Decodable {
    let rocket: Rocket
    let success: Bool?
    let name, dateUTC: String
    
    enum CodingKeys: String, CodingKey {
        case rocket,success, name
        case dateUTC = "date_utc"
    }
}

// MARK: - Rockets
enum Rocket: String, Decodable {
    case falconOne = "5e9d0d95eda69955f709d1eb"
    case falconNine = "5e9d0d95eda69973a809d1ec"
    case falconHeavy = "5e9d0d95eda69974db09d1ed"
    case starship = "5e9d0d96eda699382d09d1ee"

    var name: String {
        switch self {
        case .falconOne:
            return "Falcon 1"
        case .falconNine:
            return "Falcon 9"
        case .falconHeavy:
            return "Falcon Heavy"
        case .starship:
            return "Starship"
        }
    }
}

class LauchesSpaceX: Decodable {
    var launches: [LauchSpaceX]?
    
    init() {
        loadProductsFromJson()
        print(launches?[5].rocket as Any)
    }
    
    private func loadProductsFromJson() {
        guard let url = Bundle.main.url(forResource: "fromServerRequestLaunches", withExtension: ".json") else { print("файл json не найден")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decode = JSONDecoder()
            launches = try decode.decode([LauchSpaceX].self, from: data)
            print("Продукты успешно загружены: ")
        } catch {
            print("Ошибка при загрузке или декодировании JSON с запусками: \(error)")
        }
    }
    
    public func getLaunchesByRocket(forRocket rocket: Rocket) -> [LauchSpaceX]? {
        guard let launches = launches else { return nil }
        return launches.filter { $0.rocket == rocket }
    }
}
