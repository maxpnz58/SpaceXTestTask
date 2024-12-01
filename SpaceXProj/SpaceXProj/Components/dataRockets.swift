//
//  dataRockets.swift
//  SpaceXProj
//
//  Created by Max on 21.11.2024.
//

import Foundation

struct RocketParameter: Decodable {
    let title: String
    let parameters: [String]
    let meanings: [String]
}

// MARK: - rocketSpaceX
struct rocketSpaceX: Codable {
    let name: String
    let height:  Diameter
    let diameter: Diameter
    let mass: Mass
    let payloadWeights: [PayloadWeight]
    
    let costPerLaunch: Int
    let firstFlight: String
    let country: String
    
    let firstStage: FirstStage
    let secondStage: SecondStage
    
    let flickrImages: [String]

    enum CodingKeys: String, CodingKey {
        case name,height, diameter, mass
        case payloadWeights = "payload_weights"
        
        case costPerLaunch = "cost_per_launch"
        case firstFlight = "first_flight"
        case country
        
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        
        case flickrImages = "flickr_images"
    }
}

// MARK: - Diameter
struct Diameter: Codable {
    let meters, feet: Double?
}
// MARK: - Mass
struct Mass: Codable {
    let kg, lb: Int
}
// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let kg, lb: Int
}
// MARK: - Thrust
struct Thrust: Codable {
    let kN, lbf: Int
}
// MARK: - FirstStage
struct FirstStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?
    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}
// MARK: - SecondStage
struct SecondStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

let rocketBaseParametersNames: [(title: String, parameters: [String], meanings: [String])] = [
    (title: "", parameters: ["Первый запуск","Страна","Стоимость запуска"], meanings: ["7 февраля 2018","США","1 мрд. $"]),
    (title: "ПЕРВАЯ СТУПЕНЬ", parameters: ["К-во двигтелей","К-во топлива","Время сгорания"], meanings: ["3","10000","34"]),
    (title: "ВТОРАЯ СТПЕНЬ", parameters: ["К-во двигтелей","К-во топлива","Время сгорания"], meanings: ["6","12400","67"]),
]

class rocketsSpaceX: Decodable {
    var rockets: [rocketSpaceX]?
    
    var rocketPictures = [
        "falcon1",
        "falcon9",
        "falconHeavy",
        "starship"
    ]
    
    var rocketCollectionParametersNames = [
        ["Высота, m","Диаметр, m","Масса, kg","Загрузка, kg"],
        ["Высота, feet","Диаметр, feet","Масса, inches","Загрузка, inches"]
    ]
    
    var rocketCollectionParameters = [[String]]()
    
    
    var rocketBaseParameters = [[RocketParameter]]()

    init() {
        loadProductsFromJson()
    }
    

    private func loadProductsFromJson() {
        guard let url = Bundle.main.url(forResource: "fromServerRequestShips", withExtension: ".json") else { print("файл json не найден")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decode = JSONDecoder()
            rockets = try decode.decode([rocketSpaceX].self, from: data)
            loadRocketCollectionParameters()
            loadRocketBaseParameters()
            print("Боеголовки успешно загружены, сэр! ")
        } catch {
            print("Дэбил, у тебя ошибка при загрузке или декодировании JSON: \(error)")
        }
    }
    
    private func loadRocketCollectionParameters() {
        rockets?.forEach({ rocket in
            rocketCollectionParameters.append([
                String(rocket.height.meters!),
                String(rocket.diameter.meters!),
                String(rocket.mass.kg),
                String(rocket.payloadWeights.first!.kg),
                ])
            print(rocket.name)
        })
    }
    
    private func loadRocketBaseParameters() {
        rockets?.forEach { rocket in
            let rocketParameterInitial = RocketParameter(
                title: "",
                parameters: [
                    "Первый запуск",
                    "Страна",
                    "Стоимость запуска"
                ],
                meanings: [
                    String(rocket.firstFlight),
                    String(rocket.country),
                    String(rocket.costPerLaunch)
                ]
            )
            
            let rocketParameterOne = RocketParameter(
                title: "",
                parameters: [
                    "Количество двигателей",
                    "Количество топлива",
                    "Время сгорания"
                ],
                meanings: [
                    String(rocket.firstStage.engines),
                    String(rocket.firstStage.fuelAmountTons),
                    String(rocket.firstStage.burnTimeSEC ?? 0)
                ]
            )
            
            let rocketParameterTwo = RocketParameter(
                title: "",
                parameters: [
                    "Количество двигателей",
                    "Количество топлива",
                    "Время сгорания"
                ],
                meanings: [
                    String(rocket.secondStage.engines),
                    String(rocket.secondStage.fuelAmountTons),
                    String(rocket.secondStage.burnTimeSEC ?? 0)
                ]
            )
            
            rocketBaseParameters.append([rocketParameterInitial,rocketParameterOne,rocketParameterTwo])
        }
    }
}




